package br.uece.goes.selectionFactor.test;

import br.uece.goes.selectionFactor.test.rplanner.RPFitnessTest;
import jmetal.util.JMException;

import java.io.IOException;

/**
 * Created by Raphael on 26/05/2017.
 */
public class main {

    public static void main(String[] args) throws ClassNotFoundException, IOException, JMException {
        Teste test = new RPFitnessTest();

        test.execute(30);


    }

}
