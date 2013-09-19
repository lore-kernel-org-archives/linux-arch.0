From: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/4] gcov: add support for gcc 4.7 gcov format
Date: Thu, 19 Sep 2013 12:31:54 +0200
Message-ID: <523AD29A.3080705@linux.vnet.ibm.com>
References: <1378305776-3644-1-git-send-email-fhrbata@redhat.com> <1378305776-3644-3-git-send-email-fhrbata@redhat.com> <523ABE10.6060802@linux.vnet.ibm.com> <20130919102137.GB2313@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109]:39213 "EHLO
	e06smtp13.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869Ab3ISKbl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 Sep 2013 06:31:41 -0400
Received: from /spool/local
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <oberpar@linux.vnet.ibm.com>;
	Thu, 19 Sep 2013 11:31:39 +0100
In-Reply-To: <20130919102137.GB2313@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Frantisek Hrbata <fhrbata@redhat.com>
Cc: linux-kernel@vger.kernel.org, jstancek@redhat.com, keescook@chromium.org, peter.oberparleiter@de.ibm.com, rusty@rustcorp.com.au, linux-arch@vger.kernel.org, arnd@arndb.de, mgahagan@redhat.com, agospoda@redhat.com, akpm@linux-foundation.org

On 19.09.2013 12:21, Frantisek Hrbata wrote:
> On Thu, Sep 19, 2013 at 11:04:16AM +0200, Peter Oberparleiter wrote:
>> On 04.09.2013 16:42, Frantisek Hrbata wrote:
>>> The gcov in-memory format changed in gcc 4.7. The biggest change, w=
hich
>>> requires this special implementation, is that gcov_info no longer c=
ontains
>>> array of counters for each counter type for all functions and gcov_=
fn_info is
>>> not used for mapping of function's counters to these arrays(offset)=
=2E Now each
>>> gcov_fn_info contans it's counters, which makes things a little bit=
 easier.
>>>
>>> This is heavily based on the previous gcc_3_4.c implementation and =
patches
>>> provided by Peter Oberparleiter. Specially the buffer gcda implemen=
tation for
>>> iterator.
>>>
>>> v2: - removed const definition for gcov_fn_info in gcov_info
>>>     - use vmalloc for counter values in gcov_info_dup
>>>     - use iter buffer for gcda
>>>
>>> Signed-off-by: Frantisek Hrbata <fhrbata@redhat.com>
>>
>> The patch is missing an include statement:
>>
>>   CC      kernel/gcov/gcc_4_7.o
>> kernel/gcov/gcc_4_7.c: In function =91gcov_info_dup=92:
>> kernel/gcov/gcc_4_7.c:293:4: error: implicit declaration of function=
 =91vmalloc=92 [-Werror=3Dimplicit-function-declaration]
>> kernel/gcov/gcc_4_7.c:293:20: warning: assignment makes pointer from=
 integer without a cast [enabled by default]
>>
>> With that added, it compiles and works with gcc 4.3.4 and 4.7.2 on
>> kernel 3.21-rc1 on s390x.
>>
>> --- a/kernel/gcov/gcc_4_7.c
>> +++ b/kernel/gcov/gcc_4_7.c
>> @@ -15,6 +15,7 @@
>>  #include <linux/slab.h>
>>  #include <linux/string.h>
>>  #include <linux/seq_file.h>
>> +#include <linux/vmalloc.h>
>>  #include "gcov.h"
>>
>>  #define GCOV_COUNTERS			8
>>
>=20
> Hi Peter,
>=20
> I'm sorry I missed that. Many thanks. In addition, do you have any ot=
her
> objedtions to the code? Andrew already added the patches to the -mm t=
ree.
> Andrew, should I post a follow up patch adding the vmalloc.h include =
or is it
> possible to fix it directly as you did for the previous patches?=20
> Again I'm sorry for the inconvenience.

With the fix applied I have no further objections.

Reviewed-by: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>

Thanks!

--=20
Peter Oberparleiter
Linux on System z Development - IBM Germany
