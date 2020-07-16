From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2] powerpc: select ARCH_HAS_MEMBARRIER_SYNC_CORE
Date: Thu, 16 Jul 2020 10:56:15 +1000
Message-ID: <1594860957.3hoocg9gu6.astroid@bobo.none>
References: <20200715094829.252208-1-npiggin@gmail.com>
        <87zh816qgv.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgGPA4Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jul 2020 20:56:25 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDE4C061755
        for <linux-arch@vger.kernel.org>; Wed, 15 Jul 2020 17:56:24 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j4so5005342wrp.10
        for <linux-arch@vger.kernel.org>; Wed, 15 Jul 2020 17:56:24 -0700 (PDT)
In-Reply-To: <87zh816qgv.fsf@igel.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: =?iso-8859-1?q?Christophe=0A?= Leroy <christophe.leroy@csgroup.eu>, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Excerpts from Andreas Schwab's message of July 15, 2020 8:08 pm:
> On Jul 15 2020, Nicholas Piggin wrote:
>=20
>> diff --git a/arch/powerpc/include/asm/exception-64e.h b/arch/powerpc/inc=
lude/asm/exception-64e.h
>> index 54a98ef7d7fe..071d7ccb830f 100644
>> --- a/arch/powerpc/include/asm/exception-64e.h
>> +++ b/arch/powerpc/include/asm/exception-64e.h
>> @@ -204,7 +204,11 @@ exc_##label##_book3e:
>>  	LOAD_REG_ADDR(r3,interrupt_base_book3e);\
>>  	ori	r3,r3,vector_offset@l;		\
>>  	mtspr	SPRN_IVOR##vector_number,r3;
>> -
>> +/*
>> + * powerpc relies on return from interrupt/syscall being context synchr=
onising
>> + * (which rfi is) to support ARCH_HAS_MEMBARRIER_SYNC_CORE without addi=
tional
>> + * additional synchronisation instructions.
>=20
> s/additonal//

Will fix in a respin.

Thanks,
Nick
