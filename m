From: Michael Jin <mikhail.jin@gmail.com>
Subject: Re: [PATCH v3 16/17] driver/edac: enable Hygon support to AMD64 EDAC driver
Date: Sat, 11 Aug 2018 16:10:51 -0400
Message-ID: <CAO6F7D=voK9Vof7-c-D8TNmppJUaEj4Qhd37kdRVHxOU9mZntA@mail.gmail.com>
References: <cover.1533989492.git.puwen@hygon.cn> <cb1a56c95bbcc4d65a98378274ae34d826704a16.1533989493.git.puwen@hygon.cn>
 <CAO6F7DkdV1p59igFY3atTCRK62KH3_J-874oQw1v6ighaHOTXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAO6F7DkdV1p59igFY3atTCRK62KH3_J-874oQw1v6ighaHOTXA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pu Wen <puwen@hygon.cn>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de, pbonzini@redhat.com, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-edac@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sat, Aug 11, 2018 at 3:56 PM, Michael Jin <mikhail.jin@gmail.com> wrote:
> On Sat, Aug 11, 2018 at 9:30 AM, Pu Wen <puwen@hygon.cn> wrote:
>> @@ -1051,6 +1065,16 @@ static void determine_memory_type(struct amd64_pvt *pvt)
>>                 else
>>                         pvt->dram_type = MEM_DDR4;
>>                 return;
>> +       case 0x18:
>> +               if (pvt->vendor == X86_VENDOR_HYGON) {
>
> This vendor checking is not necessary as there are no other known
> family 18h processors.

Actually, vendor checking works here. Although, AMD has not released a
family 18h yet.
