package br.uece.goes.selectionFactor.test;

import br.uece.goes.selectionFactor.ProblemWithSelectionFactor;
import jmetal.core.Algorithm;
import jmetal.core.Problem;
import jmetal.core.Solution;
import jmetal.core.SolutionSet;
import jmetal.util.JMException;

import java.io.File;

/**
 * Created by italo on 09/06/17.
 */
public abstract class Teste {

    protected String problemName;
    protected Problem problem;
    protected Algorithm algorithm;

    protected Teste(String problemName) {
        this.problemName = problemName;
    }

    public void execute(int evaluations) throws JMException {
        problem = configProblem();
        algorithm = configAlgorithm();

        SolutionSet population = null;
        double execTime = System.currentTimeMillis();
        try {
            population = algorithm.execute();
        } catch (JMException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        execTime = System.currentTimeMillis() - execTime;

        ProblemWithSelectionFactor problemSelectionFactor = (ProblemWithSelectionFactor) problem;

        double [] value = new double[problemSelectionFactor.getNumberOfEvaluators()+1];
        value[value.length-1] = execTime;

        for (int i = 0; i < evaluations; i++) {
            for (int j = 0; j < value.length-1; j++) {
                try {
                    value[j] = problemSelectionFactor.getEvaluator(j).evaluate(population.get(0));
                } catch (JMException e) {
                    e.printStackTrace();
                }
                System.out.println(value[j]);
            }

        /* Log messages */
            new File("results").mkdirs();
            population.printObjectivesToFile("results"+File.separator+problemName+"_FUN.txt",value);
            population.printVariablesToFile("results"+File.separator+problemName+"_VAR.txt");
        }
    }

    protected abstract Problem configProblem();

    protected abstract Algorithm configAlgorithm() throws JMException;
}
