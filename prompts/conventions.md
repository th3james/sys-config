<Code Style Preferences>

## Core Philosophy:
Strive for code that is **simple, performant, and robust**. When in doubt, err on the side of clarity and directness over premature or overly complex abstractions.

## Control flow

* **Simple and explicit control flow:** Favor straightforward control structures over complex logic. Simple control flow makes code easier to understand and reduces the risk of bugs. Avoid recursion if possible to keep execution bounded and predictable, preventing stack overflows and uncontrolled resource use.
* **Limit function length:** Keep functions concise, ideally under 70 lines. Shorter functions are easier to understand, test, and debug. They promote single responsibility, where each function does one thing well, leading to a more modular and maintainable codebase.
* **Centralize control flow:** Keep switch or if statements in the main parent function, and move non-branching logic to helper functions. Let the parent function manage state, using helpers to calculate changes without directly applying them. Keep leaf functions pure and focused on specific computations. This divides responsibility: one function controls flow, others handle specific logic.
* **Minimize variable scope:** Declare variables in the smallest possible scope. Limiting scope reduces the risk of unintended interactions and misuse. It also makes the code more readable and easier to maintain by keeping variables within their relevant context.

## Error handling:

* **Use assertions:** Use assertions to verify that conditions hold true at specific points in the code. Assertions work as internal checks, increase robustness, and simplify debugging.
    * **Assert function arguments and return values:** Check that functions receive and return expected values.
    * **Validate invariants:** Keep critical conditions stable by asserting invariants during execution.
    * **Use pair assertions:** Check critical data at multiple points to catch inconsistencies early.
* **Fail fast on programmer errors:** Detect unexpected conditions immediately, stopping faulty code from continuing.
* **Handle all errors:** Check and handle every error. Ignoring errors can lead to undefined behavior, security issues, or crashes. Write thorough tests for error-handling code to make sure your application works correctly in all cases.

## Naming

Get the nouns and verbs right. Great names capture what something is or does and create a clear, intuitive model. They show you understand the domain. Take time to find good names, where nouns and verbs fit together, making the whole greater than the sum of its parts.

* **Clear and consistent naming:** Use descriptive and meaningful names for variables, functions, and files. Good naming improves code readability and helps others understand each component's purpose. Stick to a consistent style, like snake_case, throughout the codebase.

* **Avoid abbreviations:** Use full words in names unless the abbreviation is widely accepted and clear (e.g., ID, URL). Abbreviations can be confusing and make it harder for others, especially new contributors, to understand the code.

* **Include units or qualifiers in names:** Append units or qualifiers to variable names, placing them in descending order of significance (e.g., latency_ms_max instead of max_latency_ms). This clears up meaning, avoids confusion, and ensures related variables, like latency_ms_min, line up logically and group together.

* **Document the 'why':** Use comments to explain why decisions were made, not just what the code does. Knowing the intent helps others maintain and extend the code properly. Give context for complex algorithms, unusual approaches, or key constraints. Do not comment on *what* the code is doing if it's already clear.

## Organization
Organizing code well makes it easy to navigate, maintain, and extend. A logical structure reduces cognitive load, letting developers focus on solving problems instead of figuring out the code. Group related elements, and simplify interfaces to keep the codebase clean, scalable, and manageable as complexity grows.

* **Organize code logically:** Structure your code logically. Group related functions and classes together. Order code naturally, placing high-level abstractions before low-level details. Logical organization makes code easier to navigate and understand.

* **Simplify function signatures:** Keep function interfaces simple. Limit parameters, and prefer returning simple types. Simple interfaces reduce cognitive load, making functions easier to understand and use correctly.

* **Construct objects in-place:** Initialize large structures or objects directly where they are declared. In-place construction avoids unnecessary copying or moving of data, improving performance and reducing the potential for lifecycle errors.

* **Minimize variable scope:** Declare variables close to their usage and within the smallest necessary scope. This reduces the risk of misuse and makes code easier to read and maintain.

## Dependency Management:

* **Minimize external dependencies:** If a dependency is essential, prioritize those that are well-established, widely used, actively maintained, and have a proven track record of stability.
</Code Style Preferences>

<Tools>
Assume the following tools are available for use:
* [fish](https://fishshell.com/) is the default shell

Python is not globally install. If you need to run Python, use astral-sh/uv:
`uv run python -c "print('hello')"`

Tools are otherwise managed by [mise](https://mise.jdx.dev/). Look in `mise.toml` to understand how environments are configured.
</Tools>
