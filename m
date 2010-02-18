From: Jason Wessel <jason.wessel@windriver.com>
Subject: Re: [PATCH 08/28] kdb: core for kgdb back end (2
	of 2)
Date: Thu, 18 Feb 2010 12:36:11 -0600
Message-ID: <4B7D889B.80704@windriver.com>
References: <m1zl37xhmm.fsf@fess.ebiederm.org> <4B7D5704.6060504@windriver.com>
	<20100218180752.GA11626@pendragon.3leafnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kgdb-bugreport-bounces@lists.sourceforge.net>
In-Reply-To: <20100218180752.GA11626@pendragon.3leafnetworks.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kgdb-bugreport>,
	<mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kgdb-bugreport>
List-Post: <mailto:kgdb-bugreport@lists.sourceforge.net>
List-Help: <mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kgdb-bugreport>,
	<mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=subscribe>
Errors-To: kgdb-bugreport-bounces@lists.sourceforge.net
To: Scott Lurndal <scott.lurndal@3leafsystems.com>
Cc: linux-arch@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, mingo@elte.hu
List-Id: linux-arch.vger.kernel.org

Scott Lurndal wrote:
>
> IIRC the original KDB would stop all the cpus when entered,
> thus locking to avoid concurrent access to data
> was not necessary when displaying kernel data structures.  

Just because the system is "effectively frozen" does not mean you can
safely walk a structure or call something that takes a lock.

One of the key points Eric and others have made is that they do not want
some of this helper code in the kernel core, nor do they want alternate
lock semantics while the kernel debugger is active.  You can achieve the
same sort of interrogation with a gdb helper macro.  At some point kdb
could be extended to have the same sort of functionality if someone
finds they just cannot live without it.


> However,
> KDB user and developers were assumed to be aware that when KDB was
> entered the system context was in an indeterminate state particularly
> with respect to linked lists and other non-tabular data structures.
>
> KDB code that displayed data structures which were kept in a non-table
> data structure (linked list, tree, etc.) was be required to both
> validate each pointer it tries to follow as well as ensure that it
> detects loops (either by terminating the list traversal after a certain
> number of elements or by allowing the KDB user to terminate the traversal
> with e.g. 'q').
>
>   
>> It looks to me like the original kdb took the approach of calling the
>> setjmp() longjmp() and if there was any kind of fault, it long jumped
>> back to the original context.  Obviously that doesn't solve any kind of
>> problem with a list loop.
>>     
>
> Yes.   The list loop was expected to be handled either by the display
> code terminating after some number of traversal step or by the KDB user
> terminating the command via the keyboard (e.g. 'q' at a more-type prompt).
>
>   

The new kdb has a pager as well as abort operations, but it does not
make use of setjmp() longjmp() to handle faults while executing other
helper print code.

> If the new KDB framework allows other cpus to continue to run while kdb
> data structure display commands are running, then much more care must
> be taken in the display command code to avoid inconsistent data causing
> loops or #PF.
>
>   

In the new kdb.  The system is fully stopped by the kernel debug core. 
There is the concept of the master CPU (the one running the debug shell)
and the slave CPUs which are all the other cores.  All the slaves spin
in a control loop, and you may switch cpus with the kdb cpu command
without exiting the debug context.  The master can "trade places" with
an online slave cpu.

Jason.

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
