From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [Xen-devel] [PATCH v4 12/16] x86/xen: enable Hygon support to Xen
Date: Mon, 20 Aug 2018 21:43:43 -0400
Message-ID: <5917160e-4cbe-7940-ee73-70fc8086df12@oracle.com>
References: <cover.1534599097.git.puwen@hygon.cn>
 <044e5e9082d57c10a36a16a9da6404f976d7ae55.1534599097.git.puwen@hygon.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <044e5e9082d57c10a36a16a9da6404f976d7ae55.1534599097.git.puwen@hygon.cn>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pu Wen <puwen@hygon.cn>, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de, pbonzini@redhat.com, jgross@suse.com, JBeulich@suse.com
Cc: linux-arch@vger.kernel.org, xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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
