From: Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [Skiboot] [PATCH] opal/hmi: Wakeup the cpu before reading core_fir
Date: Thu, 23 Aug 2018 17:02:51 +0530
Message-ID: <877ekhnwrg.fsf@vajain21.in.ibm.com>
References: <20180820183417.dejfsluih7elbclu@pburton-laptop> <20180820223618.22319-1-paul.burton@mips.com> <20180820223618.22319-2-paul.burton@mips.com> <20180820140605.11846-1-vaibhav@linux.ibm.com> <20180821133842.1b13e972@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180821133842.1b13e972@roar.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>, Michael Neuling <mikey@neuling.org>, Stewart Smith <stewart@linux.ibm.com>, Linux-MIPS <linux-mips@linux-mips.org>, linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, James Hogan <jhogan@kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>
List-Id: linux-arch.vger.kernel.org

Thanks for reviewing this patch Nick

Nicholas Piggin <npiggin@gmail.com> writes:
>
> Would it be feasible to enumerate the ranges of scoms that require
> special wakeup and check for those in xscom_read/write, and warn if
> spwkup was not set?
>
I think that might be racy (Vaidy please correct if I am wrong) as a
core can change its state when we read its sleep state and when we do
the actual xscom to read the core_fir.

-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
