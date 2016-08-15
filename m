From: Chris Metcalf <cmetcalf@mellanox.com>
Subject: Re: [PATCH v7 4/4] nmi_backtrace: generate one-line reports for idle
 cpus
Date: Mon, 15 Aug 2016 12:41:54 -0400
Message-ID: <12bc082c-067b-2b85-6c17-ff0a6c011add@mellanox.com>
References: <1470672218-16059-1-git-send-email-cmetcalf@mellanox.com>
 <1470672218-16059-5-git-send-email-cmetcalf@mellanox.com>
 <20160809124325.GG13300@pathway.suse.cz>
 <feaaca8f-cc09-5847-ea3f-d27052704d9b@mellanox.com>
 <20160811152538.GH13300@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160811152538.GH13300@pathway.suse.cz>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Russell King <linux@arm.linux.org.uk>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Aaron Tomlin <atomlin@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On 8/11/2016 11:25 AM, Petr Mladek wrote:
> On Mon 2016-08-08 12:03:38, Chris Metcalf wrote:
>>>> When doing an nmi backtrace of many cores, most of which are idle,
>>>> the output is a little overwhelming and very uninformative.  Suppress
>>>> messages for cpus that are idling when they are interrupted and just
>>>> emit one line, "NMI backtrace for N skipped: idling at pc 0xNNN".
> Hmm, the problem is that native_safe_halt() is called from default_idle()
> here. The function is marked as inline but the compiler did not inline
> it.
>
> It helped me to put native_safe_halt() into the __cpuidle_text section:

Following Peter Z's suggestion, I have added an __always_inline marker
to native_safe_halt.  For consistency, I also did arch_safe_halt(), since that
invokes native_safe_halt, and then also native_halt() and halt(), so that
we're not being weirdly inconsistent with markings for halt inlines.

There are also the native_irq_enable(), etc., accessors in that same header
that are still only marked "inline" not "always_inline", but I wanted to stop
before I was touching too much unrelated code.

> I wonder if it would be possible to detect the idle thread an other
> way. For example, I wonder if it would be enough to check for the
> PID 0.

No, the problem is that pid 0 can also go off and run "interesting" code
for things like power management, etc., so we really just want to
focus on being quite sure that the running code isn't interesting before
we suppress the backtrace information.

See the thread around here:

https://lkml.kernel.org/r/20160307204317.GR6344@twins.programming.kicks-ass.net

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com
