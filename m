From: Michael Holzheu <holzheu-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2] kdump: Fix crash_kexec - smp_send_stop race in panic
Date: Wed, 02 Nov 2011 11:03:59 +0100
Message-ID: <1320228239.2776.14.camel@br98xy6r>
References: <1319639649.3321.11.camel@br98xy6r>
	<20111028161143.e5ebf617.akpm@linux-foundation.org>
	<1320055036.2796.8.camel@br98xy6r>
	<20111031033948.a0edb7f3.akpm@linux-foundation.org>
	<1320064459.2796.26.camel@br98xy6r> <20111101200420.GN17705@redhat.com>
Reply-To: holzheu-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20111101200420.GN17705-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: kexec-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Errors-To: kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Don Zickus <dzickus-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, heiko.carstens-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Eric W. Biederman" <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>, schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Tue, 2011-11-01 at 16:04 -0400, Don Zickus wrote:
> On Mon, Oct 31, 2011 at 01:34:19PM +0100, Michael Holzheu wrote:
> > Hello Andrew, hello linux-arch,
> > 
> > > Well OK.  Maybe some architectures do have this problem - who would
> > > notice?  If that is the case, we just made the failure cases much more
> > > common.  Could you check, please?
> > 
> > @linux-arch: 
> > 
> > This patch introduces a spinlock to prevent parallel execution of the
> > panic code. Andrew pointed out that this might be a problem for
> > architectures that can't do smp_send_stop() on remote CPUs that have
> > interrupts disabled. When irq-disabled CPUs execute panic() in parallel,
> > we then would have looping CPUs.
> 
> x86 has such problem and I posted a patch recently to fix it
> 
> https://lkml.org/lkml/2011/10/13/426

Ok good, so with this patch x86 has no problem with the panic spinlock.
Anybody else?

Instead of introducing the panic lock, as an alternative we could move
smp_send_stop() to the beginning of panic(). Eric told me that the
function is currently "insufficiently reliable" for that, but perhaps we
could make it more reliable.

Michael
