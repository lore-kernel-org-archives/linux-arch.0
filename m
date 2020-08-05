From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v10 2/5] powerpc/vdso: Prepare for switching VDSO to
 generic C implementation.
Date: Wed, 5 Aug 2020 13:40:54 -0500
Message-ID: <20200805184054.GQ6753@gate.crashing.org>
References: <cover.1596611196.git.christophe.leroy@csgroup.eu>
 <348528c33cd4007f3fee7fe643ef160843d09a6c.1596611196.git.christophe.leroy@csgroup.eu>
 <20200805140307.GO6753@gate.crashing.org>
 <3db2a590-b842-83db-ed2b-f3ee62595f18@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <3db2a590-b842-83db-ed2b-f3ee62595f18@csgroup.eu>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: nathanl@linux.ibm.com, linux-arch@vger.kernel.org, vincenzo.frascino@arm.com, arnd@arndb.de, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, luto@kernel.org, tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

Hi!

On Wed, Aug 05, 2020 at 04:40:16PM +0000, Christophe Leroy wrote:
> >It cannot optimise it because it does not know shift < 32.  The code
> >below is incorrect for shift equal to 32, fwiw.
> 
> Is there a way to tell it ?

Sure, for example the &31 should work (but it doesn't, with the GCC
version you used -- which version is that?)

> >What does the compiler do for just
> >
> >static __always_inline u64 vdso_shift_ns(u64 ns, unsigned long shift)
> >	return ns >> (shift & 31);
> >}
> >
> 
> Worse:

I cannot make heads or tails of all that branch spaghetti, sorry.

>  73c:	55 8c 06 fe 	clrlwi  r12,r12,27
>  740:	7f c8 f0 14 	addc    r30,r8,r30
>  744:	7c c6 4a 14 	add     r6,r6,r9
>  748:	7c c6 e1 14 	adde    r6,r6,r28
>  74c:	34 6c ff e0 	addic.  r3,r12,-32
>  750:	41 80 00 70 	blt     7c0 <__c_kernel_clock_gettime+0x114>

This branch is always true.  Hrm.


Segher
