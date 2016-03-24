From: Denys Vlasenko <dvlasenk@redhat.com>
Subject: Re: [PATCH 01/31] bitops: add parity functions
Date: Thu, 24 Mar 2016 09:38:21 +0100
Message-ID: <56F3A77D.6060802@redhat.com>
References: <1458788612-4367-1-git-send-email-zhaoxiu.zeng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44697 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752144AbcCXIiZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 24 Mar 2016 04:38:25 -0400
In-Reply-To: <1458788612-4367-1-git-send-email-zhaoxiu.zeng@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Martin Kepplinger <martink@posteo.de>, Sasha Levin <sasha.levin@oracle.com>, Ingo Molnar <mingo@kernel.org>, Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 03/24/2016 04:03 AM, Zhaoxiu Zeng wrote:
> +/*
> + * Type invariant interface to the compile time constant parity functions.
> + */
> +#define PARITY(w)    PARITY64((u64)w)

Can result in incorrect expansion of w. Should be PARITY64((u64)(w))
