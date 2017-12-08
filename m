Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45944 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752429AbdLHTEz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 Dec 2017 14:04:55 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7B2CC912@ORSMSX110.amr.corp.intel.com>
References: <3908561D78D1C84285E8C5FCA982C28F7B2CC912@ORSMSX110.amr.corp.intel.com> <151274828931.9961.17801232134228415862.stgit@warthog.procyon.org.uk> <151274828194.9961.4230316917108602662.stgit@warthog.procyon.org.uk> <10175.1512748454@warthog.procyon.org.uk>
Subject: Re: Does this break IA64 Linux?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <31452.1512759888.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date: Fri, 08 Dec 2017 19:04:48 +0000
Message-ID: <31453.1512759888@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: dhowells@redhat.com, "Yu, Fenghua" <fenghua.yu@intel.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <20171208190448.QiHgiiQuMLls9D1gFmiLg2OMXkkXhEOAtgpgUFI4amw@z>

Luck, Tony <tony.luck@intel.com> wrote:

> Which patch is "this patch". I don't see any link or attachment.

Sorry, I cc'd a patch which I sent to the ia64 list.  The 5th patch on this
branch:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=init_task

i.e.:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=init_task&id=aefa31699977ca8e71082b3237f949becbb03110

David
