From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v5 3/8] qspinlock, x86: Add x86 specific optimization for
	2 contending tasks
Date: Fri, 28 Feb 2014 08:25:24 -0800
Message-ID: <CA+55aFyz-7NvwUN5q8xqSvHsufC4Z1NSCvnUYrKRAhBeVjUuDA@mail.gmail.com>
References: <1393427668-60228-1-git-send-email-Waiman.Long@hp.com>
	<1393427668-60228-4-git-send-email-Waiman.Long@hp.com>
	<20140226162057.GW6835@laptop.programming.kicks-ass.net>
	<530FA32B.8010202@hp.com>
	<20140228092945.GG27965@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4431357423262262242=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140228092945.GG27965@twins.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Andi Kleen <andi@firstfloor.org>, Peter Anvin <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Alok Kataria <akataria@vmware.com>, linux-arch@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Daniel J Blueman <daniel@numascale.com>, xen-devel@lists.xenproject.org, Paul McKenney <paulmck@linux.vnet.ibm.com>, Alexander Fyodorov <halcy@yandex.ru>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, George Spelvin <linux@horizon.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, virtualization <virtualization@lists.linux-fou>
List-Id: linux-arch.vger.kernel.org

--===============4431357423262262242==
Content-Type: multipart/alternative; boundary=089e01176de591788204f379e2c3

--089e01176de591788204f379e2c3
Content-Type: text/plain; charset=UTF-8

On Feb 28, 2014 1:30 AM, "Peter Zijlstra" <peterz@infradead.org> wrote:
>
> At low contention the cmpxchg won't have to be retried (much) so using
> it won't be a problem and you get to have arbitrary atomic ops.

Peter, the difference between an atomic op and *no* atomic op is huge.

And Waiman posted numbers for the optimization. Why do you argue with
handwaving and against numbers?

       Linus

--089e01176de591788204f379e2c3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On Feb 28, 2014 1:30 AM, &quot;Peter Zijlstra&quot; &lt;<a href=3D"mailto:p=
eterz@infradead.org">peterz@infradead.org</a>&gt; wrote:<br>
&gt;<br>
&gt; At low contention the cmpxchg won&#39;t have to be retried (much) so u=
sing<br>
&gt; it won&#39;t be a problem and you get to have arbitrary atomic ops.</p=
>
<p dir=3D"ltr">Peter, the difference between an atomic op and *no* atomic o=
p is huge.</p>
<p dir=3D"ltr">And Waiman posted numbers for the optimization. Why do you a=
rgue with handwaving and against numbers?</p>
<p dir=3D"ltr">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Linus<br>
</p>

--089e01176de591788204f379e2c3--

--===============4431357423262262242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4431357423262262242==--
