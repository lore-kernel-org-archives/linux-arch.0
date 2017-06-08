Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:56260 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbdFHOCo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Jun 2017 10:02:44 -0400
Date: Thu, 08 Jun 2017 10:02:22 -0400 (EDT)
Message-ID: <20170608.100222.1573468093040905016.davem@davemloft.net>
Subject: Re: CPU_BIG_ENDIAN in generic code
From: David Miller <davem@davemloft.net>
In-Reply-To: <CAK8P3a1WfU9V1k2r=TfJSVRTymuD8n2hkJDr6u1KcmC_scAZMA@mail.gmail.com>
References: <877f0z6oig.fsf@concordia.ellerman.id.au>
        <28d6c874-4653-b15d-39b7-57a032abc9c6@oracle.com>
        <CAK8P3a1WfU9V1k2r=TfJSVRTymuD8n2hkJDr6u1KcmC_scAZMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: babu.moger@oracle.com, mpe@ellerman.id.au, geert@linux-m68k.org, peterz@infradead.org, mingo@redhat.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Message-ID: <20170608140222.IjmGHO8Rr3ZuDmpMmJcZ-f5wDUV_9rA_gxLoSGS5WO8@z>

From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 8 Jun 2017 10:01:59 +0200

> I would also suggest adding a sanity check like

Hmm, but this will kill the build for non-fixed endian architectures
won't it?
