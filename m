From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH 11/28] ARCv2: extable: Enable sorting at build time
Date: Mon, 29 Jun 2015 13:38:58 -0700
Message-ID: <5591ACE2.8050000@caviumnetworks.com>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com> <1433850508-26317-12-git-send-email-vgupta@synopsys.com> <558A4559.1070304@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2on0054.outbound.protection.outlook.com ([207.46.100.54]:9747
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752638AbbF2VLc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 29 Jun 2015 17:11:32 -0400
In-Reply-To: <558A4559.1070304@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: David Daney <david.daney@cavium.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, arc-linux-dev@synopsys.com

On 06/23/2015 10:51 PM, Vineet Gupta wrote:
> Hi David,
>
> On Tuesday 09 June 2015 05:18 PM, Vineet Gupta wrote:
>> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
>> ---
>>   scripts/sortextable.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/scripts/sortextable.c b/scripts/sortextable.c
>> index 1052d4834a44..c2423d913b46 100644
>> --- a/scripts/sortextable.c
>> +++ b/scripts/sortextable.c
>> @@ -47,6 +47,10 @@
>>   #define EM_MICROBLAZE	189
>>   #endif
>>
>> +#ifndef EM_ARCV2
>> +#define EM_ARCV2	195
>> +#endif
>> +
>>   static int fd_map;	/* File descriptor for file being modified. */
>>   static int mmap_failed; /* Boolean flag. */
>>   static void *ehdr_curr; /* current ElfXX_Ehdr *  for resource cleanup */
>> @@ -281,6 +285,7 @@ do_file(char const *const fname)
>>   		custom_sort = sort_relative_table;
>>   		break;
>>   	case EM_ARCOMPACT:
>> +	case EM_ARCV2:
>>   	case EM_ARM:
>>   	case EM_AARCH64:
>>   	case EM_MICROBLAZE:
>>
>
> Sorry for missing you in the CC in orig post of this patch. Can I get your Ack on
> this one !
>

OK:

Acked-by: David Daney <david.daney@cavium.com>


Really this is obvious, and only effects ARCv2, so the corresponding 
maintainers shouldn't need my Ack.

David Daney


> -Vineet
>
