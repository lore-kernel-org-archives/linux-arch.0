From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 2/2] kernel: Move arches to use common unaligned access
Date: Fri, 11 Apr 2008 11:27:55 +0100
Message-ID: <20196.1207909675@redhat.com>
References: <20080411.031642.193716019.davem@davemloft.net> <1207885132.22001.85.camel@brick> <15208.1207908688@redhat.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759980AbYDKK2w@vger.kernel.org>
In-Reply-To: <20080411.031642.193716019.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: dhowells@redhat.com, harvey.harrison@gmail.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org
List-Id: linux-arch.vger.kernel.org

David Miller <davem@davemloft.net> wrote:

> No, I think it has something to do with what cases GCC is allowed to
> optimize the call inline and what cases it cannot wrt.  alignment of
> datums.

As he says in his comment, in fact.

David
