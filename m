From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] Documentation: Add ARM64 to kernel-parameters.rst
Date: Fri, 12 Apr 2019 21:47:19 -0700
Message-ID: <b18a62ef-f3b7-4ae7-ad55-820fdd82d9e4@infradead.org>
References: <cover.1555085500.git.jpoimboe@redhat.com>
 <24039e1370ed57e8075730c0b88c505afd9e0ab7.1555085500.git.jpoimboe@redhat.com>
 <25174c3c-0e39-0562-7d02-bb7d51cd2b43@infradead.org>
 <20190413035621.tohihjksatqushwf@treble>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190413035621.tohihjksatqushwf@treble>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Will Deacon <will.deacon@arm.com>, Steven Price <steven.price@arm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, Waiman Long <longman@redhat.com>, linux-arch@vger.kernel.org, Jon Masters <jcm@redhat.com>, Jiri Kosina <jikos@kernel.org>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Phil Auld <pauld@redhat.com>, Greg Kroah-Hartman <gregkh@li>
List-Id: linux-arch.vger.kernel.org

On 4/12/19 8:56 PM, Josh Poimboeuf wrote:
> Add ARM64 to the legend of architectures.  It's already used in several
> places in kernel-parameters.txt.
> 
> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  Documentation/admin-guide/kernel-parameters.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
> index b8d0bc07ed0a..0124980dca2d 100644
> --- a/Documentation/admin-guide/kernel-parameters.rst
> +++ b/Documentation/admin-guide/kernel-parameters.rst
> @@ -88,6 +88,7 @@ parameter is applicable::
>  	APIC	APIC support is enabled.
>  	APM	Advanced Power Management support is enabled.
>  	ARM	ARM architecture is enabled.
> +	ARM64	ARM64 architecture is enabled.
>  	AX25	Appropriate AX.25 support is enabled.
>  	CLK	Common clock infrastructure is enabled.
>  	CMA	Contiguous Memory Area support is enabled.
> 


Thanks.

-- 
~Randy
