package br.uece.goes.selectionFactor.test;

import jmetal.util.JMException;

import java.io.IOException;

/**
 * Created by Raphael on 26/05/2017.
 */
public class main {

    public static void main(String[] args) throws ClassNotFoundException, IOException, JMException {
        GA_test ga = new GA_test();

        for (int i=0; i<30;i++){
            ga.main("Priorization","",-1,3);
        }

        for (int i=0; i<30;i++){
            ga.main("Priorization","_0",0,1);
        }

        for (int i=0; i<30;i++){
            ga.main("Priorization","_1",1,1);
        }

        for (int i=0; i<30;i++){
            ga.main("Priorization","_2",2,1);
        }


//        for (int i=0; i<30;i++){
//            ga.main("ReleasePlanning","",-1,2);
//        }
//
//        for (int i=0; i<30;i++){
//            ga.main("ReleasePlanning","_0",0,1);
//        }
//
//        for (int i=0; i<30;i++){
//            ga.main("ReleasePlanning","_1",1,1);
//        }



    }

}
