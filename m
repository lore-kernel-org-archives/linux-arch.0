Return-Path: <schwidefsky@de.ibm.com>
Received: from mtagate5.de.ibm.com ([195.212.29.154]:33993 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S265259AbUENLkY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 14 May 2004 07:40:24 -0400
Subject: Re: atomic ops for a VM fix
Message-ID: <OF76EA7F60.02519DAD-ONC1256E94.003F8E14-C1256E94.003FC398@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Fri, 14 May 2004 13:36:28 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
To: Andrew Morton <akpm@osdl.org>
Cc: davidm@napali.hpl.hp.com, davidm@hpl.hp.com, ink@jurassic.park.msu.ru, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>





> Either s390's atomic_inc_and_test() is wrong, or their
atomic_inc_return()
> is wrong.  I think the former.

atomic_inc_return is fine, atomic_inc_and_test is broken. The __CS_LOOP always
returns the new value.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com
