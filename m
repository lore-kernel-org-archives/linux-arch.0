From: Greg Ungerer <gerg@snapgear.com>
Subject: Re: [PATCH v2 01/11] m68k: switch to using the asm-generic auxvec.h
Date: Tue, 30 Oct 2012 16:21:25 +1000
Message-ID: <508F71E5.2010101@snapgear.com>
References: <1351489774-14263-2-git-send-email-gerg@snapgear.com> <1351489774-14263-1-git-send-email-gerg@snapgear.com> <18903.1351507368@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from dalsmrelay2.nai.com ([205.227.136.216]:25318 "EHLO
	dalsmrelay2.nai.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328Ab2J3GXO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 30 Oct 2012 02:23:14 -0400
In-Reply-To: <18903.1351507368@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-m68k@vger.kernel.org, linux-arch@vger.kernel.org, Greg Ungerer <gerg@uclinux.org>

Hi David,

On 29/10/12 20:42, David Howells wrote:
> <gerg@snapgear.com> wrote:
>
>> diff --git a/arch/m68k/include/uapi/asm/Kbuild b/arch/m68k/include/uapi/asm/Kbuild
>> index 972bce1..588c3cc 100644
>> --- a/arch/m68k/include/uapi/asm/Kbuild
>> +++ b/arch/m68k/include/uapi/asm/Kbuild
>> @@ -2,7 +2,6 @@
>>   include include/uapi/asm-generic/Kbuild.asm
>>
>>   header-y += a.out.h
>> -header-y += auxvec.h
>>   header-y += byteorder.h
>>   header-y += cachectl.h
>>   header-y += fcntl.h
>
> Rather than removing header-y from the uapi Kbuild, you probably want to add a
> generic-y there.

Ok, will do. v3 coming up.

Thanks
Greg

  
------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg@snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close                             FAX:         +61 7 3217 5323
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
