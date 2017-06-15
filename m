Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:47213 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbdFOUOr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Jun 2017 16:14:47 -0400
Date: Thu, 15 Jun 2017 16:13:29 -0400
In-Reply-To: <20170615153322.nwylo3dzn4fdx6n6@pd.tnic>
References: <20170607191309.28645.15241.stgit@tlendack-t1.amdoffice.net> <20170607191745.28645.81756.stgit@tlendack-t1.amdoffice.net> <20170614174208.p2yr5exs4b6pjxhf@pd.tnic> <0611d01a-19f8-d6ae-2682-932789855518@amd.com> <20170615094111.wga334kg2bhxqib3@pd.tnic> <921153f5-1528-31d8-b815-f0419e819aeb@amd.com> <20170615153322.nwylo3dzn4fdx6n6@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v6 26/34] iommu/amd: Allow the AMD IOMMU to work with memory encryption
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Message-ID: <C1A52990-84AA-4258-B864-0121F5F5C4B5@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>, Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rik van Riel <riel@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joro@8bytes.org>, Paolo Bonzini <pbonzini@redhat.com>, Larry Woodman <lwoodman@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Dave Young <dyoung@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20170615201329.lClrsa3Y7mAfTTS7gyKAq2Ly2n8xao6SLodibApMatw@z>

On June 15, 2017 11:33:22 AM EDT, Borislav Petkov <bp@alien8.de> wrote:
>On Thu, Jun 15, 2017 at 09:59:45AM -0500, Tom Lendacky wrote:
>> Actually the detection routine, amd_iommu_detect(), is part of the
>> IOMMU_INIT_FINISH macro support which is called early through
>mm_init()
>> from start_kernel() and that routine is called before init_amd().
>
>Ah, we do that there too:
>
>	for (p = __iommu_table; p < __iommu_table_end; p++) {
>
>Can't say that that code with the special section and whatnot is
>obvious. :-\
>

Patches to make it more obvious would be always welcome!



Thanks!
