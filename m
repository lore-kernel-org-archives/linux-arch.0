Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.southpole.se ([193.12.106.18]:48073 "EHLO
	mail.southpole.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755Ab2JMGvI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 13 Oct 2012 02:51:08 -0400
MIME-Version: 1.0
In-Reply-To: <20121013022954.595178706@goodmis.org>
References: <20121013022632.024527228@goodmis.org>
	<20121013022954.595178706@goodmis.org>
Date: Sat, 13 Oct 2012 08:32:36 +0200
Message-ID: <CACM3HyHnMHj=DB5FeLUfRsKT-a=KzcmdpSbudoLU7O48RzuPoA@mail.gmail.com>
Subject: Re: [PATCH 15/25] openrisc: Use Kbuild infrastructure for kvm_para.h
From: Jonas Bonn <jonas@southpole.se>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20121013063236.eHOPkHLFDHAfHunKROM4bxsKYN68kHrNcDo3exdcUdQ@z>

On 13 October 2012 04:26, Steven Rostedt <rostedt@goodmis.org> wrote:
> From: Steven Rostedt <srostedt@redhat.com>
>
> All the headers but kvm_para.h use the Kbuild infrastructure to
> get to the asm-generic headers.
>
> Cc: linux-kbuild@vger.kernel.org
> Cc: linux@lists.openrisc.net
> Cc: Jonas Bonn <jonas@southpole.se>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Acked-by: Jonas Bonn <jonas@southpole.se>
