From: Andy Lutomirski <luto@kernel.org>
Subject: Re: VDSO unmap and remap support for additional architectures
Date: Thu, 28 Apr 2016 11:53:22 -0700
Message-ID: <2ce7203f-305c-6edf-0ef9-448c141cb103@kernel.org>
References: <20151202121918.GA4523@arm.com>
 <1461856737-17071-1-git-send-email-cov@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1461856737-17071-1-git-send-email-cov@codeaurora.org>
Sender: owner-linux-mm@kvack.org
To: Christopher Covington <cov@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, criu@openvz.org, Laurent Dufour <ldufour@linux.vnet.ibm.com>, Will Deacon <Will.Deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, dsafonov@virtuozzo.com
List-Id: linux-arch.vger.kernel.org

On 04/28/2016 08:18 AM, Christopher Covington wrote:
> Please take a look at the following prototype of sharing the PowerPC
> VDSO unmap and remap code with other architectures. I've only hooked
> up arm64 to begin with. If folks think this is a reasonable approach I
> can work on 32 bit ARM as well. Not hearing back from an earlier
> request for guidance [1], I simply dove in and started hacking.
> Laurent's test case [2][3] is a compelling illustration of whether VDSO
> remap works or not on a given architecture.

I think there's a much nicer way:

https://lkml.kernel.org/r/1461584223-9418-1-git-send-email-dsafonov@virtuozzo.com

Could arm64 and ppc use this approach?  These arch_xyz hooks are gross.

Also, at some point, possibly quite soon, x86 will want a way for user code to ask the kernel to map a specific vdso variant at a specific address.  Could we perhaps add a new pair of syscalls:

struct vdso_info {
    unsigned long space_needed_before;
    unsigned long space_needed_after;
    unsigned long alignment;
};

long vdso_get_info(unsigned int vdso_type, struct vdso_info *info);

long vdso_remap(unsigned int vdso_type, unsigned long addr, unsigned int flags);

#define VDSO_X86_I386 0
#define VDSO_X86_64 1
#define VDSO_X86_X32 2
// etc.

vdso_remap will map the vdso of the chosen type such at AT_SYSINFO_EHDR lines up with addr.  It will use up to space_needed_before bytes before that address and space_needed_after after than address.  It will also unmap the old vdso (or maybe only do that if some flag is set).

On x86, mremap is *not* sufficient for everything that's needed, because some programs will need to change the vdso type.

--Andy

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
