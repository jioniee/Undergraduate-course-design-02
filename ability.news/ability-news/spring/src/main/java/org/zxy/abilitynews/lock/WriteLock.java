package org.zxy.abilitynews.lock;

import java.util.concurrent.locks.ReentrantReadWriteLock;

/**
 * @author Xingyu Zhou
 * @description: TODO
 * @date 2021/7/22 22:55
 */
public class WriteLock {

    private static WriteLock writeLock = new WriteLock();

    private static volatile ReentrantReadWriteLock lock;

    private WriteLock() {
    }

    public static WriteLock getInstance() {
        return writeLock;
    }

    public ReentrantReadWriteLock getLock() {
        if (lock == null) {
            synchronized (this) {
                if (lock == null) {
                    lock = new ReentrantReadWriteLock();
                }
            }
        }
        return lock;
    }
}
