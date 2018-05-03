From: weylin <weylin.machine@gmail.com>
Subject: Re: [PATCH v2 5/5] asm-generic: fix build error in fix_to_virt with
 CONFIG_DEBUG_EXPERIENCE
Date: Thu, 3 May 2018 16:39:09 +0000
Message-ID: <cfdd795e-e724-c6c7-cd47-1fea0fd9fa6b@gmail.com>
References: <1525268700-10631-1-git-send-email-changbin.du@intel.com>
 <1525268700-10631-6-git-send-email-changbin.du@intel.com>
 <20180502101930.25a5437d@gandalf.local.home>
 <20180503132508.qudxf67tyijvjndo@intel.com>
 <20180503101920.3157f63f@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180503101920.3157f63f@gandalf.local.home>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>, "Du, Changbin" <changbin.du@intel.com>
Cc: yamada.masahiro@socionext.com, michal.lkml@markovi.net, tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org, rdunlap@infradead.org, x86@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, arnd@arndb.de, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Dear kernel devs,

After configuring for 2 hours settings, faced below on making :

cc1: error: 
/usr/src/linux-next-master/arch/x86/crypto/serpent-sse2-x86_64-asm_64.S: 
Input/output error

Thank you for your attantion to config matter last days, It is really 
physically  hard every time sort sort out menu again. If it would 
ppossible to have standard -- Conservative Unix style secure / paranoid 
choice alongwith -- allyesconfig .


Thank you !


On 05/03/2018 02:19 PM, Steven Rostedt wrote:
> On Thu, 3 May 2018 21:25:08 +0800
> "Du, Changbin" <changbin.du@intel.com> wrote:
>
>> I think fix_to_virt() is designed for constant idx only. So I think we should
>> fix it at the caller side by replacing it with __fix_to_virt().
>>
>> --- a/arch/arm/mm/mmu.c
>> +++ b/arch/arm/mm/mmu.c
>> @@ -1599,7 +1599,7 @@ static void __init early_fixmap_shutdown(void)
>>                  pte_t *pte;
>>                  struct map_desc map;
>>
>> -               map.virtual = fix_to_virt(i);
>> +               map.virtual = __fix_to_virt(i);
>>                  pte = pte_offset_early_fixmap(pmd_off_k(map.virtual), map.virtual);
> That's a better solution than the current patch.
>
> -- Steve
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
