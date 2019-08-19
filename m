Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15314 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727744AbfHSRwZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Aug 2019 13:52:25 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7JHmdt7143502
        for <linux-arch@vger.kernel.org>; Mon, 19 Aug 2019 13:52:24 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ufx6mnvas-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 19 Aug 2019 13:52:23 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <naveen.n.rao@linux.ibm.com>;
        Mon, 19 Aug 2019 18:52:21 +0100
Date: Mon, 19 Aug 2019 23:22:13 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH 13/16] include/asm-generic: prefer __section from
 compiler_attributes.h
References: <20190812215052.71840-1-ndesaulniers@google.com>
        <20190812215052.71840-13-ndesaulniers@google.com>
In-Reply-To: <20190812215052.71840-13-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
Message-ID: <1566237106.8670clhnrk.naveen@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org, Nick Desaulniers <ndesaulniers@google.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org, clang-built-linux@googlegroups.com, Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, jpoimboe@redhat.com, Martin KaFai Lau <kafai@fb.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, miguel.ojeda.sandonis@gmail.com, netdev@vger.kernel.org, sedat.dilek@gmail.com, Song Liu <songliubraving@fb.com>, yhs@fb.com
Message-ID: <20190819175213.ucxp7uUR8EOQvaUA0EkWCQySpHSbStRTgprlY_pxE0w@z>

Nick Desaulniers wrote:
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---

Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

- Naveen
