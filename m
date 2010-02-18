From: Jason Wessel <jason.wessel@windriver.com>
Subject: Re: [PATCH 08/28] kdb: core for kgdb back end (2
	of 2)
Date: Thu, 18 Feb 2010 09:04:36 -0600
Message-ID: <4B7D5704.6060504@windriver.com>
References: <1266014143-29444-1-git-send-email-jason.wessel@windriver.com><1266014143-29444-9-git-send-email-jason.wessel@windriver.com>
	<m1zl37xhmm.fsf@fess.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kgdb-bugreport-bounces@lists.sourceforge.net>
In-Reply-To: <m1zl37xhmm.fsf@fess.ebiederm.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kgdb-bugreport>,
	<mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kgdb-bugreport>
List-Post: <mailto:kgdb-bugreport@lists.sourceforge.net>
List-Help: <mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kgdb-bugreport>,
	<mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=subscribe>
Errors-To: kgdb-bugreport-bounces@lists.sourceforge.net
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-arch@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, mingo@elte.hu, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Eric W. Biederman wrote:
> Jason Wessel <jason.wessel@windriver.com> writes:
>
>   
>> This patch contains the hooks and instrumentation into kernel which
>> live outside the kernel/debug directory, which the kdb core
>> will call to run commands like lsmod, dmesg, bt etc...
>>     
>
> You know this dropping the locks from vmalloc_info and swap_info
> is down right ugly, and I don't believe it is safe.  That code
> was not designed to run while the write_lock is held.
>   

Perhaps we can find some middle ground.  I don't mind simply not
allowing the information to be queried from kdb if the locks are not
available. 

Which is less ugly you, making the swap_lock global or adding a function
to query it?


> How does kdb build if NOMMU is set?
>   

I did not see a kernel config option called NOMMU. 

Can you point me to a kernel config that uses this?   Or is it the case
that it is something like "# CONFIG_MMU is not set"?

Perhaps we just set kdb to work only when CONFIG_MMU is enabled?  It is
hard to say it works or not without a kernel configuration, file system
and hardware to test it with.

> Similarly with si_swapinfo.  What makes it safe to run the
> code without it's locks.  Safe as in no null pointer deferences
> or other nasties.
>
>   

It looks to me like the original kdb took the approach of calling the
setjmp() longjmp() and if there was any kind of fault, it long jumped
back to the original context.  Obviously that doesn't solve any kind of
problem with a list loop.

As I mentioned earlier, I think we should check for the lock and if it
isn't available you don't get to execute the function, else a separate
function has to be written that does the same thing safely.  I do not
see any value in making a separate function to safely print the
information at this time.  If you want to probe around, consider using a
gdb macro.


> I am not impressed with the mess you make of meminfo_proc_show.
> That looks like a maintenance hazard if I ever saw one.  An innocent
> change to get some additional info (that happens to take a lock)
> will cause kdb to deadlock.
>
>   

This code goes away if we expose a way to check for the lock.


Jason.

------------------------------------------------------------------------------
Download Intel&reg; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs 
proactively, and fine-tune applications for parallel performance. 
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
