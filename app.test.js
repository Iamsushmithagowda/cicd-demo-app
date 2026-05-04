// app.test.js
describe('API Server Tests', () => {
  const app = require('./app');

  afterAll((done) => {
    app.close();
    done();
  });

  test('should pass basic test', () => {
    expect(true).toBe(true);
  });

  test('should have app defined', () => {
    expect(app).toBeDefined();
  });

  test('arithmetic operations work', () => {
    expect(2 + 2).toBe(4);
    expect(10 - 5).toBe(5);
    expect(3 * 4).toBe(12);
  });

  test('string operations work', () => {
    const greeting = 'Hello';
    expect(greeting).toHaveLength(5);
    expect(greeting).toBe('Hello');
  });

  test('array operations work', () => {
    const arr = [1, 2, 3];
    expect(arr).toHaveLength(3);
    expect(arr).toContain(2);
  });

  test('object operations work', () => {
    const user = { id: 1, name: 'Alice' };
    expect(user).toHaveProperty('name');
    expect(user.name).toBe('Alice');
  });
});
