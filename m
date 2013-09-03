From: Christoph Lameter <cl@linux.com>
Subject: [gcv v4 17/38] drivers/char: Replace __get_cpu_var uses
Date: Tue, 3 Sep 2013 21:22:20 +0000
Message-ID: <00000140e5b466fe-ea203ef6-139a-46a1-8733-e9c52f4e6df9-000000@email.amazonses.com>
References: <20130903190014.794420260@linux.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from a9-58.smtp-out.amazonses.com ([54.240.9.58]:41732 "EHLO
	a9-58.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759990Ab3ICVWW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 Sep 2013 17:22:22 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: akpm@linuxfoundation.org, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arch@vger.kernel.org, Steven Rostedt <srostedt@redhat.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>


__get_cpu_var() is used for multiple purposes in the kernel source. One of them is
address calculation via the form &__get_cpu_var(x). This calculates the address for
the instance of the percpu variable of the current processor based on an offset.

Other use cases are for storing and retrieving data from the current processors percpu area.
__get_cpu_var() can be used as an lvalue when writing data or on the right side of an assignment.

__get_cpu_var() is defined as :


#define __get_cpu_var(var) (*this_cpu_ptr(&(var)))



__get_cpu_var() always only does an address determination. However, store and retrieve operations
could use a segment prefix (or global register on other platforms) to avoid the address calculation.

this_cpu_write() and this_cpu_read() can directly take an offset into a percpu area and use
optimized assembly code to read and write per cpu variables.


This patch converts __get_cpu_var into either an explicit address calculation using this_cpu_ptr()
or into a use of this_cpu operations that use the offset. Thereby address calculations are avoided
and less registers are used when code is generated.

At the end of the patch set all uses of __get_cpu_var have been removed so the macro is removed too.

The patch set includes passes over all arches as well. Once these operations are used throughout then
specialized macros can be defined in non -x86 arches as well in order to optimize per cpu access by
f.e. using a global register that may be set to the per cpu base.




Transformations done to __get_cpu_var()


1. Determine the address of the percpu instance of the current processor.

	DEFINE_PER_CPU(int, y);
	int *x = &__get_cpu_var(y);

    Converts to

	int *x = this_cpu_ptr(&y);


2. Same as #1 but this time an array structure is involved.

	DEFINE_PER_CPU(int, y[20]);
	int *x = __get_cpu_var(y);

    Converts to

	int *x = this_cpu_ptr(y);


3. Retrieve the content of the current processors instance of a per cpu variable.

	DEFINE_PER_CPU(int, y);
	int x = __get_cpu_var(y)

   Converts to

	int x = __this_cpu_read(y);


4. Retrieve the content of a percpu struct

	DEFINE_PER_CPU(struct mystruct, y);
	struct mystruct x = __get_cpu_var(y);

   Converts to

	memcpy(&x, this_cpu_ptr(&y), sizeof(x));


5. Assignment to a per cpu variable

	DEFINE_PER_CPU(int, y)
	__get_cpu_var(y) = x;

   Converts to

	this_cpu_write(y, x);


6. Increment/Decrement etc of a per cpu variable

	DEFINE_PER_CPU(int, y);
	__get_cpu_var(y)++

   Converts to

	this_cpu_inc(y)



Signed-off-by: Christoph Lameter <cl@linux.com>

Index: linux/drivers/char/random.c
===================================================================
--- linux.orig/drivers/char/random.c	2013-08-27 14:31:00.000000000 -0500
+++ linux/drivers/char/random.c	2013-08-27 14:31:34.275916299 -0500
@@ -744,7 +744,7 @@ static DEFINE_PER_CPU(struct fast_pool,
 void add_interrupt_randomness(int irq, int irq_flags)
 {
 	struct entropy_store	*r;
-	struct fast_pool	*fast_pool = &__get_cpu_var(irq_randomness);
+	struct fast_pool	*fast_pool = this_cpu_ptr(&irq_randomness);
 	struct pt_regs		*regs = get_irq_regs();
 	unsigned long		now = jiffies;
 	__u32			input[4], cycles = get_cycles();
