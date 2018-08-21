Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:52486 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725731AbeHUFBL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Aug 2018 01:01:11 -0400
Subject: Re: [Xen-devel] [PATCH v4 12/16] x86/xen: enable Hygon support to Xen
References: <cover.1534599097.git.puwen@hygon.cn>
 <044e5e9082d57c10a36a16a9da6404f976d7ae55.1534599097.git.puwen@hygon.cn>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <5917160e-4cbe-7940-ee73-70fc8086df12@oracle.com>
Date: Mon, 20 Aug 2018 21:43:43 -0400
MIME-Version: 1.0
In-Reply-To: <044e5e9082d57c10a36a16a9da6404f976d7ae55.1534599097.git.puwen@hygon.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Pu Wen <puwen@hygon.cn>, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de, pbonzini@redhat.com, jgross@suse.com, JBeulich@suse.com
Cc: linux-arch@vger.kernel.org, xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Message-ID: <20180821014343.FSN4cN_8L1MatGamjmvGDRr6ogvx_yk9F9kl78HPZYM@z>

On 08/19/2018 12:13 PM, Pu Wen wrote:
> To make Xen works functionly on Hygon platforms, reuse AMD's Xen support
> code path for Hygon.
>
> There are six core performance events counters per thread, so there are
> six MSRs for these counters(0-5). Also there are four legacy PMC MSRs,
> they are alias of the counters(0-3).
>
> In this version of kernel Hygon use the lagacy and safe versions of MSR
> access. It works fine when VPMU enabled in Xen on Hygon platforms by
> testing with perf.
>
> Signed-off-by: Pu Wen <puwen@hygon.cn>

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
