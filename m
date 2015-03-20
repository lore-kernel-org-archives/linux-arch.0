From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 1/2] mm: Introducing arch_remap hook
Date: Sat, 21 Mar 2015 00:19:38 +0100
Message-ID: <550CAB0A.8070402@nod.at>
References: <cover.1426866405.git.ldufour@linux.vnet.ibm.com> <503499aae380db1c4673f146bcba6ad095021257.1426866405.git.ldufour@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <503499aae380db1c4673f146bcba6ad095021257.1426866405.git.ldufour@linux.vnet.ibm.com>
Sender: owner-linux-mm@kvack.org
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Jeff Dike <jdike@addtoit.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: cov@codeaurora.org, criu@openvz.org
List-Id: linux-arch.vger.kernel.org

Am 20.03.2015 um 16:53 schrieb Laurent Dufour:
> Some architecture would like to be triggered when a memory area is moved
> through the mremap system call.
> 
> This patch is introducing a new arch_remap mm hook which is placed in the
> path of mremap, and is called before the old area is unmapped (and the
> arch_unmap hook is called).
> 
> To no break the build, this patch adds the empty hook definition to the
> architectures that were not using the generic hook's definition.

Just wanted to point out that I like that new hook as UserModeLinux can benefit from it.
UML has the concept of stub pages where the UML host process can inject commands to guest processes.
Currently we play nasty games in the TLB code to make all this work.
arch_unmap() could make this stuff more clear and less error prone.

Thanks,
//richard

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
