From: Amerigo Wang <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH/RFC] Move generated files to include/generated
Date: Wed, 22 Jul 2009 17:58:18 +0800
Message-ID: <20090722095818.GH6281@cr0.nay.redhat.com>
References: <20090721211040.GA7688@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:9259 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858AbZGVJ4I (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jul 2009 05:56:08 -0400
Content-Disposition: inline
In-Reply-To: <20090721211040.GA7688@merkur.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, linux arch <linux-arch@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>

On Tue, Jul 21, 2009 at 11:10:40PM +0200, Sam Ravnborg wrote:
>In 2.6.30 we introduced support for adding generated
>files to a dedicated directory named "include/generated".
>


Personally, I don't like this, I hate to see
#include <generated/foo.h>
.

>This had a number of benefits:
>
>  - avoid mixing generated and normal files

I don't think this is an advantage...


>  - allow us to finally kill the asm symlink


This makes sense, but it looks like only when 'make O=xxx',
no?


>  - simpler .gitignore rules
>  - simpler list of mrproper files

Neither these two.

The benifits we get is little, I think.

Thanks.
