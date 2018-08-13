From: Michael Jin <mikhail.jin@gmail.com>
Subject: Re: [PATCH v3 16/17] driver/edac: enable Hygon support to AMD64 EDAC driver
Date: Mon, 13 Aug 2018 12:47:19 -0400
Message-ID: <CAO6F7DnU=nB+mf458sRBH0ozub8bog9-zi8-awYBJumkEjDdXg@mail.gmail.com>
References: <cover.1533989492.git.puwen@hygon.cn> <cb1a56c95bbcc4d65a98378274ae34d826704a16.1533989493.git.puwen@hygon.cn>
 <CAO6F7DkdV1p59igFY3atTCRK62KH3_J-874oQw1v6ighaHOTXA@mail.gmail.com> <68538d23-8880-29a2-decd-f63b48667274@hygon.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <68538d23-8880-29a2-decd-f63b48667274@hygon.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: Pu Wen <puwen@hygon.cn>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de, pbonzini@redhat.com, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-edac@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Aug 13, 2018 at 12:17 PM, Pu Wen <puwen@hygon.cn> wrote:
> On 2018/8/12 3:56, Michael Jin wrote:
>>
>> On Sat, Aug 11, 2018 at 9:30 AM, Pu Wen <puwen@hygon.cn> wrote:
>>>
>>> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
>>> -       if (pvt->fam == 0x17) {
>>> +       if (pvt->fam == 0x17 || pvt->vendor == X86_VENDOR_HYGON) {
>>>                  __f17h_set_scrubval(pvt, scrubval);
>>
>>
>> Separating the vendor check as an "else if (pvt->vendor ==
>> X86_VENDOR_HYGON)" block would make architectural changes (future
>> hygon models, i.e. 19h, 20h, etc) less confusing.
>
>
> Your suggestion is reasonable, but that might make the branch a little
> complicated.If we explicitly testing Hygon family in condition case,
> will that be ok?
> +    if (pvt->fam == 0x17 ||
> +       (pvt->vendor == X86_VENDOR_HYGON && pvt->fam == 0x18))

The condition case for family 18h and vendor Hygon looks better
because it is more clear.

Michael
