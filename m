Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from rgminet01.oracle.com ([148.87.113.118]:60927 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030762AbXDPP2j (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 16 Apr 2007 11:28:39 -0400
Date: Mon, 16 Apr 2007 08:30:11 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH] Report that kernel is tainted if there were an OOPS
 before
Message-Id: <20070416083011.9ac0a9d7.randy.dunlap@oracle.com>
In-Reply-To: <46234E9E.6080107@sw.ru>
References: <46234E9E.6080107@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Pavel Emelianov <xemul@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, devel@openvz.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 16 Apr 2007 14:23:26 +0400 Pavel Emelianov wrote:

> If the kernel OOPS-ed or BUG-ed then it probably should
> considered as tainted. Use die_counter introduced by many
> architectures to determine whether or not the kernel died.
> 
> This saves a lot of time explaining oddities in the
> calltrace seen via SysRq-P.

argh, attachment...

+ *  'D' - An OOPS has hapened.

                      happened.


You also need to update Documentation/oops-tracing.txt.

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
