From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH 10/11] qspinlock: Paravirt support
Date: Mon, 16 Jun 2014 18:08:21 -0400
Message-ID: <539F6AD5.4070301@hp.com>
References: <20140615124657.264658593@chello.nl>
	<20140615130154.213923590@chello.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4842352029062544892=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140615130154.213923590@chello.nl>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-arch@vger.kernel.org, riel@redhat.com, gleb@redhat.com, kvm@vger.kernel.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, scott.norton@hp.com, raghavendra.kt@linux.vnet.ibm.com, paolo.bonzini@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Peter Zijlstra <peterz@infradead.org>, chegu_vinod@hp.com, david.vrabel@citrix.com, oleg@redhat.com, xen-devel@lists.xenproject.org, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, mingo@kernel.org
List-Id: linux-arch.vger.kernel.org

This is a multi-part message in MIME format.
--===============4842352029062544892==
Content-Type: multipart/alternative;
 boundary="------------070407030705080700010809"

This is a multi-part message in MIME format.
--------------070407030705080700010809
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/15/2014 08:47 AM, Peter Zijlstra wrote:
>
>
>
> +#ifdef CONFIG_PARAVIRT_SPINLOCKS
> +
> +/*
> + * Write a comment about how all this works...
> + */
> +
> +#define _Q_LOCKED_SLOW	(2U<<  _Q_LOCKED_OFFSET)
> +
> +struct pv_node {
> +	struct mcs_spinlock	mcs;
> +	struct mcs_spinlock	__offset[3];
> +	int cpu, head;
> +};

I am wondering why you need the separate cpu and head variables. I 
thought one will be enough here. The wait code put the cpu number in 
head, the the kick_cpu code kick the one in cpu which is just the cpu # 
of the tail.

> +
> +#define INVALID_HEAD	-1
> +#define NO_HEAD		nr_cpu_ids
> +

I think it is better to use a constant like -2 for NO_HEAD instead of an 
external variable.

> +void __pv_init_node(struct mcs_spinlock *node)
> +{
> +	struct pv_node *pn = (struct pv_node *)node;
> +
> +	BUILD_BUG_ON(sizeof(struct pv_node)>  5*sizeof(struct mcs_spinlock));
> +
> +	pn->cpu = smp_processor_id();
> +	pn->head = INVALID_HEAD;
> +}
> +
> +static inline struct pv_node *pv_decode_tail(u32 tail)
> +{
> +	return (struct pv_node *)decode_tail(tail);
> +}
> +
> +void __pv_link_and_wait_node(u32 old, struct mcs_spinlock *node)
> +{
> +	struct pv_node *ppn, *pn = (struct pv_node *)node;
> +	unsigned int count;
> +
> +	if (!(old&  _Q_TAIL_MASK)) {
> +		pn->head = NO_HEAD;
> +		return;
> +	}
> +
> +	ppn = pv_decode_tail(old);
> +	ACCESS_ONCE(ppn->mcs.next) = node;
> +
> +	while (ppn->head == INVALID_HEAD)
> +		cpu_relax();
> +
> +	pn->head = ppn->head;

A race can happen here as pn->head can be changed to the head cpu by the 
head waiter while being changed by this function at the same time. It is 
safer to use cmpxchg to make sure that there is no accidental 
overwriting of the head CPU number.

> +
> +	for (;;) {
> +		count = SPIN_THRESHOLD;
> +
> +		do {
> +			if (smp_load_acquire(&node->locked))
> +				return;
> +
> +			cpu_relax();
> +		} while (--count);
> +
> +		pv_wait(&node->locked, 1);
> +	}
> +}
> +
> +void __pv_kick_node(struct mcs_spinlock *node)
> +{
> +	struct pv_node *pn = (struct pv_node *)node;
> +
> +	pv_kick(pn->cpu);
> +}
> +
> +void __pv_wait_head(struct qspinlock *lock)
> +{
> +	unsigned int count;
> +	struct pv_node *pn;
> +	int val, old, new;
> +
> +	for (;;) {
> +		count = SPIN_THRESHOLD;
> +
> +		do {
> +			val = smp_load_acquire(&lock->val.counter);
> +			if (!(val&  _Q_LOCKED_PENDING_MASK))
> +				return;
> +		} while (--count);
> +
> +		do {
> +			pn = pv_decode_tail(atomic_read(&lock->val));
> +
> +			while (pn->head == INVALID_HEAD)
> +				cpu_relax();
> +
> +			pn->head = smp_processor_id();
> +
> +		} while (pn != pv_decode_tail(atomic_read(&lock->val)));
> +
> +		/*
> +		 * Set _Q_LOCKED_SLOW; bail when the lock is free.
> +		 */
> +		val = atomic_read(&lock->val);
> +		for (;;) {
> +			if (!(val&  _Q_LOCKED_PENDING_MASK))
> +				return;
> +			new = val | _Q_LOCKED_SLOW;
> +			old = atomic_cmpxchg(&lock->val, val, new);
> +			if (old == val)
> +				break;
> +			val = old;
> +		}
> +
> +		/* XXX 16bit would be better */
> +		pv_wait(&lock->val.counter, new);
> +	}
> +}
> +
> +static void ___pv_kick_head(struct qspinlock *lock)
> +{
> +	struct pv_node *pn;
> +
> +	pn = pv_decode_tail(atomic_read(&lock->val));
> +
> +	while (pn->head == INVALID_HEAD)
> +		cpu_relax();
> +
> +	if (WARN_ON_ONCE(pn->head == NO_HEAD))
> +		return;
> +
> +	pv_kick(pn->head);
> +}
> +
> +void __pv_queue_unlock(struct qspinlock *lock)
> +{
> +	int val = atomic_read(&lock->val);
> +
> +	native_queue_unlock(lock);
> +
> +	if (val&  _Q_LOCKED_SLOW)
> +		___pv_kick_head(lock);
> +}
> +

Again a race can happen here between the reading and writing of the lock 
value. I can't think of a good way to do that without using cmpxchg.

> +#else
> +
> +static inline void pv_init_node(struct mcs_spinlock *node) { }
> +static inline void pv_link_and_wait_node(u32 old, struct mcs_spinlock *node) { }
> +static inline void pv_kick_node(struct mcs_spinlock *node) { }
> +
> +static inline void pv_wait_head(struct qspinlock *lock) { }
> +
> +#endif
> +
>   /**
>    * queue_spin_lock_slowpath - acquire the queue spinlock
>    * @lock: Pointer to queue spinlock structure
> @@ -247,6 +417,9 @@ void queue_spin_lock_slowpath(struct qsp
>
>   	BUILD_BUG_ON(CONFIG_NR_CPUS>= (1U<<  _Q_TAIL_CPU_BITS));
>
> +	if (pv_enabled())
> +		goto queue;
> +
>   	if (virt_queue_spin_lock(lock))
>   		return;
>
> @@ -323,6 +496,7 @@ void queue_spin_lock_slowpath(struct qsp
>   	node += idx;
>   	node->locked = 0;
>   	node->next = NULL;
> +	pv_init_node(node);
>
>   	/*
>   	 * We touched a (possibly) cold cacheline in the per-cpu queue node;
> @@ -343,6 +517,7 @@ void queue_spin_lock_slowpath(struct qsp
>   	/*
>   	 * if there was a previous node; link it and wait.
>   	 */
> +	pv_link_and_wait_node(old, node);
>   	if (old&  _Q_TAIL_MASK) {
>   		prev = decode_tail(old);
>   		ACCESS_ONCE(prev->next) = node;
> @@ -358,6 +533,7 @@ void queue_spin_lock_slowpath(struct qsp
>   	 *
>   	 * *,x,y ->  *,0,0
>   	 */
> +	pv_wait_head(lock);
>   	while ((val = smp_load_acquire(&lock->val.counter))&
>   			_Q_LOCKED_PENDING_MASK)
>   		cpu_relax();
> @@ -391,6 +567,7 @@ void queue_spin_lock_slowpath(struct qsp
>   		cpu_relax();
>
>   	arch_mcs_spin_unlock_contended(&next->locked);
> +	pv_kick_node(next);
>   

pv_kick_node is an expensive operation and it can significantly slow 
down the locking operation if we have to do it for every subsequent task 
in the queue.

-Longman


--------------070407030705080700010809
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    On 06/15/2014 08:47 AM, Peter Zijlstra wrote:
    <blockquote type="cite">
      <div class="moz-text-plain" wrap="true" graphical-quote="true"
        style="font-family: -moz-fixed; font-size: 12px;"
        lang="x-unicode">
        <pre wrap="">
 
 
 
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+
+/*
+ * Write a comment about how all this works...
+ */
+
+#define _Q_LOCKED_SLOW	(2U &lt;&lt; _Q_LOCKED_OFFSET)
+
+struct pv_node {
+	struct mcs_spinlock	mcs;
+	struct mcs_spinlock	__offset[3];
+	int cpu, head;
+};</pre>
      </div>
    </blockquote>
    <br>
    I am wondering why you need the separate cpu and head variables. I
    thought one will be enough here. The wait code put the cpu number in
    head, the the kick_cpu code kick the one in cpu which is just the
    cpu # of the tail.<br>
    <br>
    <blockquote type="cite">
      <div class="moz-text-plain" wrap="true" graphical-quote="true"
        style="font-family: -moz-fixed; font-size: 12px;"
        lang="x-unicode">
        <pre wrap="">
+
+#define INVALID_HEAD	-1
+#define NO_HEAD		nr_cpu_ids
+</pre>
      </div>
    </blockquote>
    <br>
    I think it is better to use a constant like -2 for NO_HEAD instead
    of an external variable.<br>
    <br>
    <blockquote type="cite">
      <div class="moz-text-plain" wrap="true" graphical-quote="true"
        style="font-family: -moz-fixed; font-size: 12px;"
        lang="x-unicode">
        <pre wrap="">
+void __pv_init_node(struct mcs_spinlock *node)
+{
+	struct pv_node *pn = (struct pv_node *)node;
+
+	BUILD_BUG_ON(sizeof(struct pv_node) &gt; 5*sizeof(struct mcs_spinlock));
+
+	pn-&gt;cpu = smp_processor_id();
+	pn-&gt;head = INVALID_HEAD;
+}
+
+static inline struct pv_node *pv_decode_tail(u32 tail)
+{
+	return (struct pv_node *)decode_tail(tail);
+}
+
+void __pv_link_and_wait_node(u32 old, struct mcs_spinlock *node)
+{
+	struct pv_node *ppn, *pn = (struct pv_node *)node;
+	unsigned int count;
+
+	if (!(old &amp; _Q_TAIL_MASK)) {
+		pn-&gt;head = NO_HEAD;
+		return;
+	}
+
+	ppn = pv_decode_tail(old);
+	ACCESS_ONCE(ppn-&gt;mcs.next) = node;
+
+	while (ppn-&gt;head == INVALID_HEAD)
+		cpu_relax();
+
+	pn-&gt;head = ppn-&gt;head;</pre>
      </div>
    </blockquote>
    <br>
    A race can happen here as pn-&gt;head can be changed to the head cpu
    by the head waiter while being changed by this function at the same
    time. It is safer to use cmpxchg to make sure that there is no
    accidental overwriting of the head CPU number.<br>
    <br>
    <blockquote type="cite">
      <div class="moz-text-plain" wrap="true" graphical-quote="true"
        style="font-family: -moz-fixed; font-size: 12px;"
        lang="x-unicode">
        <pre wrap="">
+
+	for (;;) {
+		count = SPIN_THRESHOLD;
+
+		do {
+			if (smp_load_acquire(&amp;node-&gt;locked))
+				return;
+
+			cpu_relax();
+		} while (--count);
+
+		pv_wait(&amp;node-&gt;locked, 1);
+	}
+}
+
+void __pv_kick_node(struct mcs_spinlock *node)
+{
+	struct pv_node *pn = (struct pv_node *)node;
+
+	pv_kick(pn-&gt;cpu);
+}
+
+void __pv_wait_head(struct qspinlock *lock)
+{
+	unsigned int count;
+	struct pv_node *pn;
+	int val, old, new;
+
+	for (;;) {
+		count = SPIN_THRESHOLD;
+
+		do {
+			val = smp_load_acquire(&amp;lock-&gt;val.counter);
+			if (!(val &amp; _Q_LOCKED_PENDING_MASK))
+				return;
+		} while (--count);
+
+		do {
+			pn = pv_decode_tail(atomic_read(&amp;lock-&gt;val));
+
+			while (pn-&gt;head == INVALID_HEAD)
+				cpu_relax();
+
+			pn-&gt;head = smp_processor_id();
+
+		} while (pn != pv_decode_tail(atomic_read(&amp;lock-&gt;val)));
+
+		/*
+		 * Set _Q_LOCKED_SLOW; bail when the lock is free.
+		 */
+		val = atomic_read(&amp;lock-&gt;val);
+		for (;;) {
+			if (!(val &amp; _Q_LOCKED_PENDING_MASK))
+				return;
+			new = val | _Q_LOCKED_SLOW;
+			old = atomic_cmpxchg(&amp;lock-&gt;val, val, new);
+			if (old == val)
+				break;
+			val = old;
+		}
+
+		/* XXX 16bit would be better */
+		pv_wait(&amp;lock-&gt;val.counter, new);
+	}
+}</pre>
      </div>
    </blockquote>
    <blockquote type="cite">
      <div class="moz-text-plain" wrap="true" graphical-quote="true"
        style="font-family: -moz-fixed; font-size: 12px;"
        lang="x-unicode">
        <pre wrap="">
+
+static void ___pv_kick_head(struct qspinlock *lock)
+{
+	struct pv_node *pn;
+
+	pn = pv_decode_tail(atomic_read(&amp;lock-&gt;val));
+
+	while (pn-&gt;head == INVALID_HEAD)
+		cpu_relax();
+
+	if (WARN_ON_ONCE(pn-&gt;head == NO_HEAD))
+		return;
+
+	pv_kick(pn-&gt;head);
+}
+
+void __pv_queue_unlock(struct qspinlock *lock)
+{
+	int val = atomic_read(&amp;lock-&gt;val);
+
+	native_queue_unlock(lock);
+
+	if (val &amp; _Q_LOCKED_SLOW)
+		___pv_kick_head(lock);
+}
+</pre>
      </div>
    </blockquote>
    <br>
    Again a race can happen here between the reading and writing of the
    lock value. I can't think of a good way to do that without using
    cmpxchg.<br>
    <br>
    <blockquote type="cite">
      <div class="moz-text-plain" wrap="true" graphical-quote="true"
        style="font-family: -moz-fixed; font-size: 12px;"
        lang="x-unicode">
        <pre wrap="">
+#else
+
+static inline void pv_init_node(struct mcs_spinlock *node) { }
+static inline void pv_link_and_wait_node(u32 old, struct mcs_spinlock *node) { }
+static inline void pv_kick_node(struct mcs_spinlock *node) { }
+
+static inline void pv_wait_head(struct qspinlock *lock) { }
+
+#endif
+
 /**
  * queue_spin_lock_slowpath - acquire the queue spinlock
  * @lock: Pointer to queue spinlock structure
@@ -247,6 +417,9 @@ void queue_spin_lock_slowpath(struct qsp
 
 	BUILD_BUG_ON(CONFIG_NR_CPUS &gt;= (1U &lt;&lt; _Q_TAIL_CPU_BITS));
 
+	if (pv_enabled())
+		goto queue;
+
 	if (virt_queue_spin_lock(lock))
 		return;
 
@@ -323,6 +496,7 @@ void queue_spin_lock_slowpath(struct qsp
 	node += idx;
 	node-&gt;locked = 0;
 	node-&gt;next = NULL;
+	pv_init_node(node);
 
 	/*
 	 * We touched a (possibly) cold cacheline in the per-cpu queue node;
@@ -343,6 +517,7 @@ void queue_spin_lock_slowpath(struct qsp
 	/*
 	 * if there was a previous node; link it and wait.
 	 */
+	pv_link_and_wait_node(old, node);
 	if (old &amp; _Q_TAIL_MASK) {
 		prev = decode_tail(old);
 		ACCESS_ONCE(prev-&gt;next) = node;
@@ -358,6 +533,7 @@ void queue_spin_lock_slowpath(struct qsp
 	 *
 	 * *,x,y -&gt; *,0,0
 	 */
+	pv_wait_head(lock);
 	while ((val = smp_load_acquire(&amp;lock-&gt;val.counter)) &amp;
 			_Q_LOCKED_PENDING_MASK)
 		cpu_relax();
@@ -391,6 +567,7 @@ void queue_spin_lock_slowpath(struct qsp
 		cpu_relax();
 
 	arch_mcs_spin_unlock_contended(&amp;next-&gt;locked);
+	pv_kick_node(next);
 </pre>
      </div>
    </blockquote>
    <br>
    pv_kick_node is an expensive operation and it can significantly slow
    down the locking operation if we have to do it for every subsequent
    task in the queue.<br>
    <br>
    -Longman<br>
    <br>
  </body>
</html>

--------------070407030705080700010809--

--===============4842352029062544892==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4842352029062544892==--
