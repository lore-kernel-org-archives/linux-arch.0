Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33050 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151AbcEBBFs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 1 May 2016 21:05:48 -0400
Subject: Re: [RFC 1/5] powerpc: Rename context.vdso_base to context.vdso
References: <20151202121918.GA4523@arm.com>
 <1461856737-17071-1-git-send-email-cov@codeaurora.org>
 <1461856737-17071-2-git-send-email-cov@codeaurora.org>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <5726A7D5.7030305@gmail.com>
Date: Mon, 2 May 2016 11:05:25 +1000
MIME-Version: 1.0
In-Reply-To: <1461856737-17071-2-git-send-email-cov@codeaurora.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christopher Covington <cov@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, criu@openvz.org, Laurent Dufour <ldufour@linux.vnet.ibm.com>, Will Deacon <Will.Deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Message-ID: <20160502010525.7e30rvg1im85Jdylc_NU9M65Yjhd3DjCHfrps3D9F_c@z>



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
