Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:42412 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfKZINb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 26 Nov 2019 03:13:31 -0500
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiBsb29wIG5lc3RpbmcgaW4gYWxpZ25t?=
 =?UTF-8?Q?ent_exception_and_machine_check?=
References: <D44062DC474617438D5181ADFE2B2C21016DE42A@dggemi529-mbs.china.huawei.com>
 <8215aeb3-57dd-223a-29d3-45ca22b0543c@c-s.fr>
 <D44062DC474617438D5181ADFE2B2C21016E9EAA@dggemi529-mbs.china.huawei.com>
 <ef93fa2f-d98f-2e94-322e-0ae095626e75@c-s.fr>
 <D44062DC474617438D5181ADFE2B2C21016ED78D@dggemi529-mbs.china.huawei.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <a77f2266-b654-087c-7af8-78c745a52b37@c-s.fr>
Date: Tue, 26 Nov 2019 09:13:28 +0100
MIME-Version: 1.0
In-Reply-To: <D44062DC474617438D5181ADFE2B2C21016ED78D@dggemi529-mbs.china.huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "alistair@popple.id.au" <alistair@popple.id.au>, "chengjian (D)" <cj.chengjian@huawei.com>, Xiexiuqi <xiexiuqi@huawei.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "oss@buserror.net" <oss@buserror.net>, "paulus@samba.org" <paulus@samba.org>, "Libin (Huawei)" <huawei.libin@huawei.com>, "agust@denx.de" <agust@denx.de>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Message-ID: <20191126081328.DnEP_VdwDl-ARi-P26yaFjAt6O0gz_tbkgIczguJOxI@z>

Hi,

Le 01/11/2019 à 02:57, Wangshaobo (bobo) a écrit :
> Hi, Christophe
> 
> 	I am sorry that we are in some troubles for some unpredictable problems when we replay and haven't given you a quick reply.
> 	
> 	I also want to ask does the phenomeon(use memcpy_toio when copy ioremap_address) only occurs in powerpc ? does any other
> arch also has the same problem ? we are in persuit of asking why this phenomenon happened. Our linux kernel version is 4.4.

It's not a problem ... it's a feature.

I have no idea whether the same kind of issue can happen on other 
arches, sorry.

Christophe

> 	
> 	thanks very much.
> 
> -----邮件原件-----
> 发件人: Christophe Leroy [mailto:christophe.leroy@c-s.fr]
> 发送时间: 2019年10月31日 19:13
> 收件人: Wangshaobo (bobo) <bobo.shaobowang@huawei.com>
> 抄送: chengjian (D) <cj.chengjian@huawei.com>; Libin (Huawei) <huawei.libin@huawei.com>; Xiexiuqi <xiexiuqi@huawei.com>; zhangyi (F) <yi.zhang@huawei.com>
> 主题: Re: 答复: loop nesting in alignment exception and machine check
> 
> Hi,
> 
> Did you try ? Does it work ?
> 
> Christophe
> 
> Le 28/10/2019 à 06:57, Wangshaobo (bobo) a écrit :
>> Hi,Christophe
>>
>> Thank you for your quick reply. I will try to use memcpy_toio() instead of memcpy().
>>
>> -----邮件原件-----
>> 发件人: Christophe Leroy [mailto:christophe.leroy@c-s.fr]
>> 发送时间: 2019年10月26日 19:20
>> 收件人: Wangshaobo (bobo) <bobo.shaobowang@huawei.com>
>> 抄送: linux-arch@vger.kernel.org; alistair@popple.id.au; chengjian (D)
>> <cj.chengjian@huawei.com>; Xiexiuqi <xiexiuqi@huawei.com>;
>> linux-kernel@vger.kernel.org; oss@buserror.net; paulus@samba.org;
>> Libin (Huawei) <huawei.libin@huawei.com>; agust@denx.de;
>> linuxppc-dev@lists.ozlabs.org
>> 主题: Re: loop nesting in alignment exception and machine check
>>
>> Hi,
>>
>> Le 26/10/2019 à 09:23, Wangshaobo (bobo) a écrit :
>>> Hi,
>>>
>>> I encountered a problem about a loop nesting occurred in
>>> manufacturing the alignment exception in machine check, trigger background is :
>>>
>>> problem:
>>>
>>> machine checkout or critical interrupt ->…->kbox_write[for recording
>>> last words] -> memcpy(irremap_addr, src,size):_GLOBAL(memcpy)…
>>>
>>> when we enter memcpy,a command ‘dcbz r11,r6’ will cause a alignment
>>> exception, in this situation,r11 loads the ioremap address,which
>>> leads to the alignment exception,
>>
>> You can't use memcpy() on something else than memory.
>>
>> For an ioremapped area, you have to use memcpy_toio()
>>
>> Christophe
>>
>>>
>>> then the command can not be process successfully,as we still in
>>> machine check.at the end ,it triggers a new irq machine check in irq
>>> handler function,a loop nesting begins.
>>>
>>> analysis:
>>>
>>> We have analysed a lot,but it still can not come to a reasonable
>>> description,in common,the alignment triggered in machine check
>>> context can still be collected into the Kbox
>>>
>>> after alignment exception be handled by handler function, but how
>>> does the machine checkout can be triggered in the handler fucntion
>>> for any causes? We print relevant registers
>>>
>>> as follow when first enter machine check and alignment exception
>>> handler
>>> function:
>>>
>>>             MSR:0x2      MSR:0x0
>>>
>>>             SRR1:0x2      SRR1:0x21002
>>>
>>>             But the manual says SRR1 should be set to MSR(0x2),why
>>> that happened ?
>>>
>>>             Then a branch in handler function copy the SRR1 to
>>> MSR,this enble MSR[ME] and MSR[CE],system collapses.
>>>
>>> Conclusion:
>>>
>>>             1)  why the alignment exception can not be handled in
>>> machine check ?
>>>
>>>             2)  besides memcpy,any other function can cause the
>>> alignment exception ?
>>>
>>> We still recurrent it, the line as follows:
>>>
>>>             Cpu dead lock->watch log->trigger
>>> fiq->kbox_write->memcpy->alignment exception->print last words.
>>>
>>>             but for those problems as below,what the kbox printed is empty.
>>>
>>> ------------------kbox restart:[   10.147594]----------------
>>>
>>> kbox verify fs magic fail
>>>
>>> kbox mem mabye destroyed, format it
>>>
>>> kbox: load OK
>>>
>>> lock-task: major[249] minor[0]
>>>
>>> -----start show_destroyed_kbox_mem_head----
>>>
>>> 00000000: 00000000 00000000 00000000 00000000  ................
>>>
>>> 00000010: 00000000 00000000 00000000 00000000  ................
>>>
>>> 00000020: 00000000 00000000 00000000 00000000  ................
>>>
>>> 00000030: 00000000 00000000 00000000 00000000  ................
>>>
>>> 00000040: 00000000 00000000 00000000 00000000  ................
>>>
>>> 00000050: 00000000 00000000 00000000 00000000  ................
>>>
>>> 00000060: 00000000 00000000 00000000 00000000  ................
>>>
>>> 00000070: 00000000 00000000 00000000 00000000  ................
>>>
>>> 00000080: 00000000 00000000 00000000 00000000  ................
>>>
>>> 00000090: 00000000 00000000 00000000 00000000  ................
>>>
