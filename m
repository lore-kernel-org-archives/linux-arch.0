From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v10 01/26] Documentation/x86: Add CET description
Date: Mon, 18 May 2020 07:26:52 -0700
Message-ID: <05b4dd11-eb30-5ed8-4249-0396c3136428@intel.com>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
 <20200429220732.31602-2-yu-cheng.yu@intel.com>
 <b5197a8d-5d8b-e1f7-68d4-58d80261904c@intel.com>
 <dd5b9bab31ecf247a0b4890e22bfbb486ff52001.camel@intel.com>
 <5cc163ff9058d1b27778e5f0a016c88a3b1a1598.camel@intel.com>
 <b0581ddc-0d99-cbcf-278e-0be55ba939a0@intel.com>
 <44c055342bda4fb4730703f987ae35195d1d0c38.camel@intel.com>
 <32235ffc-6e6c-fb3d-80c4-a0478e2d0e0f@intel.com>
 <b09658f92eb66c1d1be509813939b9ed827f9cf0.camel@intel.com>
 <631f071c-c755-a818-6a97-b333eb1fe21c@intel.com>
 <0f751be6d25364c25ee4bddc425b61e626dcd942.camel@intel.com>
 <6f2ef0e5-d3bb-2b52-dc81-8228fec4a3f5@intel.com>
 <CAMe9rOpX_6Zn69ZzwVt5Rdh5B9HwU7ccyoQLfyM067G8A=Eg-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:45833 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbgERO06 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 18 May 2020 10:26:58 -0400
In-Reply-To: <CAMe9rOpX_6Zn69ZzwVt5Rdh5B9HwU7ccyoQLfyM067G8A=Eg-Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H.J. Lu" <hjl.tools@gmail.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>

On 5/18/20 7:01 AM, H.J. Lu wrote:
>> Could some of this information be added to the documentation, please?
>> It would also be nice to have some more details about how apps end up
>> using ARCH_X86_CET_STATUS.  Why would they care that CET is on?
> CET software spec is at
> 
> https://gitlab.com/x86-psABIs/x86-64-ABI/-/wikis/Intel-CET-extension
> 
> My CET presentation at 2018 LPC is at
> 
> https://www.linuxplumbersconf.org/event/2/contributions/147/attachments/72/83/CET-LPC-2018.pdf
> 
> I am working on an updated CET presentation for 2020 LPC.  Let me know
> if you want to see the early draft.

There's a lot of great information in there!

However, please remember that presentations are no substitute for old
fashioned documentation in the kernel tree and changelogs.  The fact
that we need to lean on them to answer basic questions about new
interfaces is not a great sign.
