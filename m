From: "Jan Beulich" <jbeulich-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] move BUG_TABLE into RODATA
Date: Wed, 23 Apr 2008 07:36:06 +0100
Message-ID: <480EF4F6.76E4.0078.0@novell.com>
References: <480E1BEE.76E4.0078.0@novell.com>
 <20080422180732.GA27222@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080422180732.GA27222-QabhHTsIXMSnlFQ6Q1D1Y0B+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

>>> Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org> 22.04.08 20:07 >>>
>Hi Jan.
>
>> --- linux-2.6.25/arch/x86/kernel/vmlinux_64.lds.S	2008-04-17 04:49:44.000000000 +0200
>> +++ 2.6.25-bug-table-rodata/arch/x86/kernel/vmlinux_64.lds.S	2008-03-04 11:14:13.000000000 +0100
>> @@ -19,7 +19,7 @@ PHDRS {
>>  	data PT_LOAD FLAGS(7);	/* RWE */
>>  	user PT_LOAD FLAGS(7);	/* RWE */
>>  	data.init PT_LOAD FLAGS(7);	/* RWE */
>> -	note PT_NOTE FLAGS(4);	/* R__ */
>> +	note PT_NOTE FLAGS(0);	/* ___ */
>>  }
>
>Is this intentional in this patch?

Yes. While it may be possible to do this separately, it seemed safer to
me to keep it together since I only tested it this way.

>>  SECTIONS
>>  {
>> @@ -40,16 +40,14 @@ SECTIONS
>>  	_etext = .;		/* End of text section */
>>    } :text = 0x9090
>>  
>> +  NOTES :text :note
>> +
>>    . = ALIGN(16);		/* Exception table */
>>    __ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {
>>    	__start___ex_table = .;
>>  	 *(__ex_table)
>>    	__stop___ex_table = .;
>> -  }
>> -
>> -  NOTES :text :note
>> -
>> -  BUG_TABLE :text
>> +  } :text = 0x9090
>
>And I do not see the 0x9090 justified.
>Is this something to do with the fact that 0x90 equals NOP on x86?

Yes, for consistency I think this ought to be repeated here - while
not strictly necessary (__ex_table is data, hence padding with
zeroes rather than NOPs would be fine), it seems more safe to have
it here so that we don't catch occasional linker bugs. Ultimately I
would think __ex_table should go into RODATA, too, which would
eliminate the question.

Jan
