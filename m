Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp20.cstnet.cn ([159.226.251.20]:47590 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728455AbeHMTCm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 Aug 2018 15:02:42 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v3 16/17] driver/edac: enable Hygon support to AMD64 EDAC
 driver
References: <cover.1533989492.git.puwen@hygon.cn>
 <cb1a56c95bbcc4d65a98378274ae34d826704a16.1533989493.git.puwen@hygon.cn>
 <CAO6F7DkdV1p59igFY3atTCRK62KH3_J-874oQw1v6ighaHOTXA@mail.gmail.com>
 <CAO6F7D=voK9Vof7-c-D8TNmppJUaEj4Qhd37kdRVHxOU9mZntA@mail.gmail.com>
Message-ID: <731415d4-b52d-1211-3439-073225083425@hygon.cn>
Date: Tue, 14 Aug 2018 00:19:36 +0800
MIME-Version: 1.0
In-Reply-To: <CAO6F7D=voK9Vof7-c-D8TNmppJUaEj4Qhd37kdRVHxOU9mZntA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Jin <mikhail.jin@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de, pbonzini@redhat.com, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-edac@vger.kernel.org
Message-ID: <20180813161936.z-RD6thJbc4Xr3LAkaHlBy_iw8LDFS9NrH2fYSr7Cr0@z>

On 2018/8/12 4:10, Michael Jin wrote:
> On Sat, Aug 11, 2018 at 3:56 PM, Michael Jin <mikhail.jin@gmail.com> wrote:
>> On Sat, Aug 11, 2018 at 9:30 AM, Pu Wen <puwen@hygon.cn> wrote:
>>> @@ -1051,6 +1065,16 @@ static void determine_memory_type(struct amd64_pvt *pvt)
>>>                  else
>>>                          pvt->dram_type = MEM_DDR4;
>>>                  return;
>>> +       case 0x18:
>>> +               if (pvt->vendor == X86_VENDOR_HYGON) {
>>
>> This vendor checking is not necessary as there are no other known
>> family 18h processors.
> 
> Actually, vendor checking works here. Although, AMD has not released a
> family 18h yet.

Yes, that's the case.

Thanks,
Pu Wen
