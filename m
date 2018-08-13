Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp20.cstnet.cn ([159.226.251.20]:46324 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728763AbeHMTBO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 Aug 2018 15:01:14 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v3 16/17] driver/edac: enable Hygon support to AMD64 EDAC
 driver
References: <cover.1533989492.git.puwen@hygon.cn>
 <cb1a56c95bbcc4d65a98378274ae34d826704a16.1533989493.git.puwen@hygon.cn>
 <CAO6F7DkdV1p59igFY3atTCRK62KH3_J-874oQw1v6ighaHOTXA@mail.gmail.com>
Message-ID: <68538d23-8880-29a2-decd-f63b48667274@hygon.cn>
Date: Tue, 14 Aug 2018 00:17:55 +0800
MIME-Version: 1.0
In-Reply-To: <CAO6F7DkdV1p59igFY3atTCRK62KH3_J-874oQw1v6ighaHOTXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Jin <mikhail.jin@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de, pbonzini@redhat.com, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-edac@vger.kernel.org
Message-ID: <20180813161755.NXE5PfePWrMaOzBpmIw6_4O3frqZEduv_SRCQtGf4sA@z>

On 2018/8/12 3:56, Michael Jin wrote:
> On Sat, Aug 11, 2018 at 9:30 AM, Pu Wen <puwen@hygon.cn> wrote:
>> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
>> index 18aeabb..fb81354 100644
>> --- a/drivers/edac/amd64_edac.c
>> +++ b/drivers/edac/amd64_edac.c
>> @@ -211,7 +211,7 @@ static int __set_scrub_rate(struct amd64_pvt *pvt, u32 new_bw, u32 min_rate)
>>
>>          scrubval = scrubrates[i].scrubval;
>>
>> -       if (pvt->fam == 0x17) {
>> +       if (pvt->fam == 0x17 || pvt->vendor == X86_VENDOR_HYGON) {
>>                  __f17h_set_scrubval(pvt, scrubval);
> 
> Separating the vendor check as an "else if (pvt->vendor ==
> X86_VENDOR_HYGON)" block would make architectural changes (future
> hygon models, i.e. 19h, 20h, etc) less confusing.

Your suggestion is reasonable, but that might make the branch a little
complicated.If we explicitly testing Hygon family in condition case,
will that be ok?
+    if (pvt->fam == 0x17 ||
+       (pvt->vendor == X86_VENDOR_HYGON && pvt->fam == 0x18))

> 
>> +                       amd64_read_pci_cfg(pvt->F6,
>> +                               F17H_SCR_BASE_ADDR, &scrubval);
>> +                       if (scrubval & BIT(0)) {
>> +                               amd64_read_pci_cfg(pvt->F6,
> 
> The new lines after "amd64_read_pci_cfg(pvt->F6," can be removed.

To fix the warning "line over 80 characters" reported by running the
checking script checkpatch.pl, I added the new line.
But your sugesstion is reasonable, remove the new line will make the
codes much easier to read.

>> @@ -1051,6 +1065,16 @@ static void determine_memory_type(struct amd64_pvt *pvt)
>>                  else
>>                          pvt->dram_type = MEM_DDR4;
>>                  return;
>> +       case 0x18:
>> +               if (pvt->vendor == X86_VENDOR_HYGON) {
> 
> This vendor checking is not necessary as there are no other known
> family 18h processors.
> 
> 
>>          switch (pvt->fam) {
>> @@ -3192,6 +3227,13 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
>>                  pvt->ops        = &family_types[F17_CPUS].ops;
>>                  break;
>>
>> +       case 0x18:
>> +               if (pvt->vendor == X86_VENDOR_HYGON) {
>> +                       fam_type        = &family_types[HYGON_F18_CPUS];
>> +                       pvt->ops        = &family_types[HYGON_F18_CPUS].ops;
>> +                       break;
>> +               }
> 
> There is a missing second 'break' statement after the "if (pvt->vendor
> == X86_VENDOR_HYGON)" block for case 0x18, see case 0x15 and case 0x16
> for comparison.

The missed second 'break' is on purpose. Thinking that if BIOS report
a vendor AMD and family 18h processor(which is not in case now),
the code will fall through and print out "Unsupported family".

> 
>> diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
>> index 2ab4d61..f7adc47 100644
>> +       case 0x18:
>> +               if (c->x86_vendor == X86_VENDOR_HYGON) {
>> +                       xec_mask = 0x3f;
>> +                       if (!boot_cpu_has(X86_FEATURE_SMCA)) {
>> +                               pr_warn("Decoding supported only on Scalable MCA processors.\n");
>> +                               goto err_out;
>> +                       }
>> +                       break;
>> +               }
> 
> The 'break' statement could be moved outside of the "if (c->x86_vendor
> == X86_VENDOR_HYGON)" block, this is to allow case 0x18 to reach the
> 'break' statement if the vendor is not X86_VENDOR_HYGON.

For the same reason as previous, if the vendor is not X86_VENDOR_HYGON,
it's not a valid vendor by now, and should fall through to the default
case and print out error message.

Thanks,
Pu Wen
