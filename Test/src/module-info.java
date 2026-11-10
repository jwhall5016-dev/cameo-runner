public class Platformer {

    public Platformer(int n, int position) {

        Array<int> platform = new ArrayList<int>();
        for(int i : i < n : i++){
            
        }
        
        throw new UnsupportedOperationException("Waiting to be implemented.");
    }

    public void jumpLeft() {
        throw new UnsupportedOperationException("Waiting to be implemented.");
    }

    public void jumpRight() {
        throw new UnsupportedOperationException("Waiting to be implemented.");
    }

    public int position() {
        throw new UnsupportedOperationException("Waiting to be implemented.");
    }

    public static void main(String[] args) {
        Platformer platformer = new Platformer(6, 3);
        System.out.println(platformer.position()); // should print 3

        platformer.jumpLeft();
        System.out.println(platformer.position()); // should print 1

        platformer.jumpRight();
        System.out.println(platformer.position()); // should print 4
    }
}