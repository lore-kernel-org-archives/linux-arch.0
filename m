From: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH 12/14] docs: move remaining stuff under
 Documentation/*.txt to Documentation/staging
Date: Mon, 04 May 2020 15:21:53 +0530
Message-ID: <1588585777.904qzycqcn.naveen@linux.ibm.com>
References: <cover.1588345503.git.mchehab+huawei@kernel.org>
        <28687056965ff46c0e6c81663a419bc59cfb94b4.1588345503.git.mchehab+huawei@kernel.org>
        <20200504085415.db8e0e3b40e795f2fb4af009@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8288 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728339AbgEDJxJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 May 2020 05:53:09 -0400
In-Reply-To: <20200504085415.db8e0e3b40e795f2fb4af009@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, Arnd Bergmann <arnd@arndb.de>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Bristot de Oliveira <bristot@redhat.com>, Jonathan Corbet <corbet@lwn.net>, "David S. Miller" <davem@davemloft.net>, =?iso-8859-1?q?Greg=0A?= Kroah-Hartman <gregkh@linuxfoundation.org>, Jens Wiklander <jens.wiklander@linaro.org>, Lecopzer Chen <lecopzer.chen@mediatek.com>, linux-arch@vger.kernel.org, Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org, =?iso-8859-1?q?Sameer=0A?= Rahmani <lxsameer@gnu.org>, Ingo Molnar <mingo@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, St

Masami Hiramatsu wrote:
> On Fri,  1 May 2020 17:37:56 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
>> There are several files that I was unable to find a proper place
>> for them, and 3 ones that are still in plain old text format.
>> 
>> Let's place those stuff behind the carpet, as we'd like to keep the
>> root directory clean.
>> 
>> We can later discuss and move those into better places.
> 
> Hi Mauro,
> 
> Thanks for cleaning it up! Tentatively moving kprobes.txt under
> staging/ is good to me.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> BTW, I think kprobes.txt is under trace/ or we may be better
> making a new core-api/events/ directory and prepare other event
> systems (PMU, uprobes, and hw_breakpoint.) 

I think it would be good to move kprobes.txt under trace/ -- all other 
tracing bits are already present there, including uprobes.


- Naveen
