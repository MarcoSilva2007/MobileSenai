package Controller;

import java.util.ArrayList;
import java.util.List;

import Model.Aluno;
import Model.Professor;

public class CursoController {
    // Atributos
    private String nomeCurso;
    private Professor professor;
    private List<Aluno> alunosList;
    // Metodos
    // Construtores
    public CursoController(String nomeCurso, Professor professor) {
        this.nomeCurso = nomeCurso;
        this.professor = professor;
        alunosList = new ArrayList<>();
    }
    // Adicionar alunos(create)
    public void adicionarAluno(Aluno aluno) {
        alunosList.add(aluno);
    }
    // Exibir informações do curso(read)
    public void exibirInformacoes() {
        System.out.println("Nome do curso: " +nomeCurso);
        System.out.println("Professor: " +professor.getNome());
        System.out.println("========Alunos=======");
        int contator = 0;
        for (Aluno aluno : alunosList) {
            contator ++;
            System.out.println(contator + ". " +aluno.getNome());
        }
        System.out.println("=====================");
    }    
    //Lançar nota
    
    //Ver status da turma
}