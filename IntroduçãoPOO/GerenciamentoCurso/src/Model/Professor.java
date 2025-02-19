package Model;

public class Professor extends Pessoas {
    private double salario;
    // Métodos
    // Construtor
    public Professor(String nome, String cpf, double salario) {
        super(nome, cpf);
        this.salario = salario;
    }
    // Metodos Getters e Setters
    public double getSalario() {
        return salario;
    }
    public void setSalario(double salario) {
        this.salario = salario;
    }
    @Override
    public void exibirInformacoes() {
        super.exibirInformacoes();
        System.out.println("Salario: " +salario);
    }
}