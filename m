Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:33492 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfEGWvA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 May 2019 18:51:00 -0400
Date: Tue, 7 May 2019 22:50:49 +0000
From: Joseph Myers <joseph@codesourcery.com>
Subject: Re: [PATCH] uapi: avoid namespace conflict in linux/posix_types.h
In-Reply-To: <20190319165123.3967889-1-arnd@arndb.de>
Message-ID: <alpine.DEB.2.21.1905072249570.19308@digraph.polyomino.org.uk>
References: <20190319165123.3967889-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-api@vger.kernel.org, linux-arch@vger.kernel.org, netdev@vger.kernel.org, Laura Abbott <labbott@redhat.com>, Florian Weimer <fw@deneb.enyo.de>, Paul Burton <pburton@wavecomp.com>, Deepa Dinamani <deepa.kernel@gmail.com>, linux-kernel@vger.kernel.org
Message-ID: <20190507225049.RsZIAfFNi0opQQu8dlo_yN_NrEIa2o1d6gojYanuAw0@z>

What happened with this patch (posted 19 March)?  I found today that we 
can't use Linux 5.1 headers in glibc testing because the namespace issues 
are still present in the headers as of the release.

-- 
Joseph S. Myers
joseph@codesourcery.com
