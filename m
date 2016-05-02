From: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [RFC 1/5] powerpc: Rename context.vdso_base to context.vdso
Date: Mon, 2 May 2016 11:05:25 +1000
Message-ID: <5726A7D5.7030305@gmail.com>
References: <20151202121918.GA4523@arm.com>
 <1461856737-17071-1-git-send-email-cov@codeaurora.org>
 <1461856737-17071-2-git-send-email-cov@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1461856737-17071-2-git-send-email-cov@codeaurora.org>
Sender: owner-linux-mm@kvack.org
To: Christopher Covington <cov@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, criu@openvz.org, Laurent Dufour <ldufour@linux.vnet.ibm.com>, Will Deacon <Will.Deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-arch.vger.kernel.org



On 29/04/16 01:18, Christopher Covington wrote:
> In order to share remap and unmap support for the VDSO with other
> architectures without duplicating the code, we need a common name and type
> for the address of the VDSO. An informal survey of the architectures
> indicates unsigned long vdso is popular. Change the variable name in
> powerpc from mm->context.vdso_base to simply mm->context.vdso.
> 

Could you please provide additional details on why the remap/unmap operations are required?
This patch does rename, but should it abstract via a function acesss to vmap field using arch_* operations? Not sure

Balbir Singh

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
