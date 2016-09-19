From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH][RFC] Implement arch primitives for busywait loops
Date: Mon, 19 Sep 2016 18:48:16 +1000
Message-ID: <20160919184816.26a3e3e9@roar.ozlabs.ibm.com>
References: <20160916085736.7857-1-npiggin@gmail.com>
 <77737e9a-e8d7-0f2d-2303-8fdbaf45b8bb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <77737e9a-e8d7-0f2d-2303-8fdbaf45b8bb@gmail.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

On Mon, 19 Sep 2016 17:45:52 +1000
Balbir Singh <bsingharora@gmail.com> wrote:

> On 16/09/16 18:57, Nicholas Piggin wrote:
> > Implementing busy wait loops with cpu_relax() in callers poses
> > some difficulties for powerpc.
> > 
> > First, we want to put our SMT thread into a low priority mode for the
> > duration of the loop, but then return to normal priority after exiting
> > the loop.  Dependong on the CPU design, 'HMT_low() ; HMT_medium();' as
> > cpu_relax() does may have HMT_medium take effect before HMT_low made
> > any (or much) difference.
> > 
> > Second, it can be beneficial for some implementations to spin on the
> > exit condition with a statically predicted-not-taken branch (i.e.,
> > always predict the loop will exit).
> >   
> 
> IIUC, what you are proposing is that cpu_relax() be split such 
> that on entry we do HMT_low() and on exit do HMT_medium(). I think
> that makes a lot of sense, in that it allows the required transition
> time from low to medium

Basically yes, although also allowing the loop exit branch to be
overridden by the arch code too. That can possibly benefit some
microarchitectures -- e.g., you want loop exit to not take a branch
miss if possible but it may be acceptable to branch miss for every
other iteration. I'm doing some testing of it now (previous patch
was garbage btw, don't try to use it!)


> > diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
> > index 68e3bf5..e10aee2 100644
> > --- a/arch/powerpc/include/asm/processor.h
> > +++ b/arch/powerpc/include/asm/processor.h
> > @@ -402,6 +402,28 @@ static inline unsigned long __pack_fe01(unsigned int fpmode)
> >  
> >  #ifdef CONFIG_PPC64
> >  #define cpu_relax()	do { HMT_low(); HMT_medium(); barrier(); } while (0)
> > +
> > +#define spin_do						\  
> 
> How about cpu_relax_begin()?
> 
> > +do {							\
> > +	HMT_low();					\
> > +	__asm__ __volatile__ (	"1010:");
> > +
> > +#define spin_while(cond)				\  
> 
> cpu_relax_while()
> > +	barrier();					\
> > +	__asm__ __volatile__ (	"cmpdi	%0,0	\n\t"	\
> > +				"beq-	1010b	\n\t"	\
> > +				: : "r" (cond));	\
> > +	HMT_medium();					\
> > +} while (0)
> > +  
> 
> 
> > +#define spin_until(cond)				\  
> 
> This is just spin_while(!cond) from an implementation perspective right?

Yes, the only reason I put it in was because such spin loops often
read a bit better the other way from normal loops (you are interested
in the exit condition rather than the loop-again condition).

> 
> cpu_relax_until()
> 
> > +	barrier();					\
> > +	__asm__ __volatile__ (	"cmpdi	%0,0	\n\t"	\
> > +				"bne-	1010b	\n\t"	\
> > +				: : "r" (cond));	\
> > +	HMT_medium();					\
> > +} while (0)
> > +  
> 
> Then add cpu_relax_end() that does HMT_medium()

Hmm. I see what you mean, but I don't know if we should trust open
coded callers to get this right. It could cause weird problems and
isn't easily caught. If we can get something that breaks build,
perhaps. OTOH, I prefer all the logic including SMT priority to be
in the spin loop primitive directly because it's pretty subtle and
might need to be runtime patched.

We could *also* have a cpu_relax_begin/cpu_relax_end pair, although
I'd like to first see callers that don't suit spin_ primitives and
see what should be done.

Thanks,
Nick
