From: Chris Metcalf <cmetcalf-kv+TWInifGbQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] kdump: Fix crash_kexec - smp_send_stop race in panic
Date: Thu, 10 Nov 2011 10:11:48 -0500
Message-ID: <4EBBE9B4.3040009@tilera.com>
References: <1319639649.3321.11.camel@br98xy6r>
 <20111028161143.e5ebf617.akpm@linux-foundation.org>
 <1320055036.2796.8.camel@br98xy6r>
 <20111031033948.a0edb7f3.akpm@linux-foundation.org>
 <1320314844.2989.6.camel@br98xy6r>
 <20111109160400.cc2d27d9.akpm@linux-foundation.org>
 <1320934932.16425.14.camel@br98xy6r>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1320934932.16425.14.camel@br98xy6r>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: kexec-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Errors-To: kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: holzheu-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org
Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Heiko Carstens <heiko.carstens-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Chen Liqin <liqin.chen-+XGAvkf1AAHby3iVrkZq2A@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Guan Xuetao <gxt-TG0Ac1+ktVePQbnJrJN+5g@public.gmane.org>, Lennox Wu <lennox.wu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hans-Christian Egtvedt <egtvedt-BrfabpQBY5qlHtIdYg32fQ@public.gmane.org>, Jonas Bonn <jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org>, Jesper Nilsson <jesper.nilsson-VrBV9hrLPhE@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>, Helge Deller <deller-Mmb7MZpHnFY@public.gmane.org>, "James E.J.
 Bottomley" <jejb-6jwH94ZQLHl74goWV3ctuw@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matt Turner <mattst88-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Haavard Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On 11/10/2011 9:22 AM, Michael Holzheu wrote:
> On Wed, 2011-11-09 at 16:04 -0800, Andrew Morton wrote:
>> On Thu, 03 Nov 2011 11:07:24 +0100
>> Michael Holzheu<holzheu-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>  wrote:
> [snip]
>
>> Ho hum, I guess we stick with the original patch.  It *should* work, as
>> long as all archtectures are doing the expected thing.  But in this
>> situation it is bad of us to just hope that the architectures are doing
>> this.  We should go and find out, rather than waiting for bug reports
>> to come in.  Especially because in this case, bugs will take a very
>> long time indeed to even be noticed.
>>
>> One way to resolve this would be to ask the various arch maintainers!
> Hello arch maintainers (from scripts/get_maintainer.pl),
>
> Andrew asked me to contact you in this case.
>
> The main concern of the patch below is that smp_send_stop() might not be
> able to stop irq-disabled CPUs. So when two CPUs enter in parallel
> panic() and the 2nd one has irqs disabled, with my patch below, perhaps
> the 2nd CPU can't be stopped. On s390 and also on x86 (with a patch from
> Don Zickus) this is not a problem.

On tile the smp_send_stop() is delivered via IPIs that respect irq 
disabling, i.e. we wouldn't handle the message on the 2nd cpu in your 
scenario above.

This may not be a problem on many architectures, though.  If one or more 
cpus is blocked in spin_lock(), that may be just as effective from a 
"machine halt" point of view as if those cpus had handled the smp_stop_cpu 
interrupt, which on tile just leaves the cpu with interrupts disabled 
anyway, though sitting on a lower-power "nap" instruction rather than 
spinning trying to acquire the lock.  (It may also be the case that on some 
architectures you need to have shepherded all the cpus into the "machine 
halt" state before you can reboot them, though that's not true on tile.)

If a cleaner API seems useful (either for power reasons or restartability 
or whatever), I suppose a standard global function name could be specified 
that's the thing you execute when you get an smp_send_stop IPI (in tile's 
case it's "smp_stop_cpu_interrupt()") and the panic() code could instead 
just do an atomic_inc_return() of a global panic counter, and if it wasn't 
the first panicking cpu, call directly into the smp_stop handler routine to 
quiesce itself.  Then the panicking cpu could finish whatever it needs to 
do and then halt, reboot, etc., all the cpus.

For what it's worth we do see the condition sometimes when a bunch of cpus 
try to panic near-simultaneously and you get crazy interleaved panic 
output, so I'd certainly support some patch of this nature.
-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
