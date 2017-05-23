## SelectionFactor

## KnapSack Problem Variant (A simple example)

Supose a thief is going to steal a story. Into such a story there is many packaged products with labels containing information
about the product's weight, volume and value. Thus, thief has a decision making problem of deciding which products he will 
steal. He aims at getting the most valued products with less weight in order to facilitate his scape. In addition, the sum
of the volumes of the choosen problem cannot be greater than capacity of his bag.

Thus the mathematical formulation for this problem consists in:

![](https://latex.codecogs.com/gif.latex?%5Cdpi%7B120%7D%20%5C%5C%20%5Cmax%20%5Csum_%7Bi%3D0%7D%5E%7BN%7D%20value_i%20%5Ctimes%20x_i%20%5C%5C%20%5Cmin%20%5Csum_%7Bi%3D0%7D%5E%7BN%7D%20weight_i%20%5Ctimes%20x_i%20%5C%5C%20%5C%5C%20%5C%5C%20subject%20%5C%20to%3A%5C%5C%20%5C%5C%20%5Csum_%7Bi%3D0%7D%5E%7BN%7D%20volume_i%20%5Ctimes%20x_i%20%5Cleq%20Capacity)

where N is the number of products into the story and x_i represents de decision variable which is x_i = 1, if the product i
was chosen to be stolen, and x_i = 0 otherwise.

###### Let's code it!

```java

public class KnapSackVariantProblem extends ProblemWithSelectionFactor {
    // Volumes, weights and values of each itens (6 items)
    double [] volume = {5000.0,   20000.0,   12000.0,  3000.0,   15000.0,  30000.0};    //cm³
    double [] weight = {0.04,   10.0,      20.0,     30.0,     3.0,      4.0   };    //Kg
    double [] value =  {10.0,     300000.0,  80.0,     0.125,  0.5,    1.0    };    //U$

    double capacity = 20000;

    public KnapSackVariantProblem() {

        solutionType_ = new IntSolutionType(this); // Solution int type
        numberOfObjectives_ = 1; //
        numberOfVariables_ = volume.length;
        problemName_ = "KnapSackVariant";

        upperLimit_ = new double[numberOfVariables_]; // AS we have a binary problem the upper limit of the variables is 1
        lowerLimit_ = new double[numberOfVariables_]; // and the lower limit 0

        for (int i = 0; i < numberOfVariables_; i++) {
            upperLimit_[i] = 1;
            lowerLimit_[i] = 0;
        }
      .
      .
      .
}
```

For each metric that we want to maximize or minimize, we have to create an Evaluator,
which calculates the value of a metric for a given solution as can be seen in the code below. If we want to maximize a metric, its evaluator must return
its value mutiplied by -1 as we can see in the second Evaluator implemented in the code below. The first Evaluator
represents a soft constraint to avoid that the volume of the chosen products does not exceed the capacity of the bag.
Observe that function addEvaluator can have two arguments, addEvaluator(Evaluator e, Double weight), if you do not set a weight
the default value is 1, as we want our soft constraint to penalize really hard invalid solutions, we added 50 to its weight.

```java
  .
  .
  .
public KnapSackVariantProblem() {
        .
        .
        .
       
        //Soft Constraint of the bag capacity
        addEvaluator(new Evaluator(this) {
            @Override
            public double evaluate(Solution solution) throws JMException{
                Variable [] variables = solution.getDecisionVariables();

                double sumOfVolumes = 0;

                for (int i = 0; i < variables.length; i++) {
                    sumOfVolumes += variables[i].getValue()*volume[i];
                }

                return (sumOfVolumes > capacity)? 1 : 0;
            }
        }, 50);

        //Evaluator for Values
        addEvaluator(new Evaluator(this) {
            @Override
            public double evaluate(Solution solution) throws JMException{
                Variable [] variables = solution.getDecisionVariables();

                double sumOfValues = 0;

                for (int i = 0; i < variables.length; i++) {
                    sumOfValues += variables[i].getValue()*value[i];
                }

                return -sumOfValues;
            }
        });

        //Evaluator for Weights
        addEvaluator(new Evaluator(this) {
            @Override
            public double evaluate(Solution solution) throws JMException{
                Variable [] variables = solution.getDecisionVariables();

                double sumOfWeights = 0;

                for (int i = 0; i < variables.length; i++) {
                    sumOfWeights += variables[i].getValue()*weight[i];
                }

                return sumOfWeights;
            }
        });

    }
    .
    .
    .
```

## Implementing and running a Genetic Algorithm



