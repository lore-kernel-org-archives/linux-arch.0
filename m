From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH v7 03/28] x86/asm/suspend: use SYM_DATA for data
Date: Tue, 5 Feb 2019 08:34:09 +0100
Message-ID: <975ba79b-5a3d-b244-7d00-869b1da246b9@suse.cz>
References: <20190130124711.12463-1-jslaby@suse.cz>
 <20190130124711.12463-4-jslaby@suse.cz> <20190204201831.GK29639@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190204201831.GK29639@zn.tnic>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: mingo@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-pm@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 04. 02. 19, 21:18, Borislav Petkov wrote:
>> --- a/arch/x86/kernel/acpi/wakeup_64.S
>> +++ b/arch/x86/kernel/acpi/wakeup_64.S
>> @@ -133,4 +133,4 @@ saved_rbx:		.quad	0
>>  saved_rip:		.quad	0
>>  saved_rsp:		.quad	0
>>  
>> -ENTRY(saved_magic)	.quad	0
>> +SYM_DATA(saved_magic,	.quad	0)
> 
> Ok, I like the proper ELF symbol typing with this: NOTYPE goes away.
> 
>  74408: ffffffff82021920     0 NOTYPE  GLOBAL DEFAULT   11 saved_magic
> 
> ->
> 
>  74366: ffffffff820218f0     8 OBJECT  GLOBAL DEFAULT   11 saved_magic

I also suggest noticing the size 0 -> 8 change ;).

thanks,
-- 
js
suse labs
