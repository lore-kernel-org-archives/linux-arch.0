Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from resqmta-ch2-05v.sys.comcast.net ([69.252.207.37]:40580 "EHLO
        resqmta-ch2-05v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752497AbeEHNC0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 May 2018 09:02:26 -0400
Date: Tue, 8 May 2018 07:54:15 -0500 (CDT)
From: Christopher Lameter <cl@linux.com>
Subject: Re: [PATCH] mm: expland documentation over __read_mostly
In-Reply-To: <20180507231506.4891-1-mcgrof@kernel.org>
Message-ID: <alpine.DEB.2.21.1805080753590.1849@nuc-kabylake>
References: <20180507231506.4891-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: tglx@linutronix.de, arnd@arndb.de, keescook@chromium.org, luto@amacapital.net, longman@redhat.com, viro@zeniv.linux.org.uk, willy@infradead.org, ebiederm@xmission.com, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20180508125415.wj-bynwHZb7c5IxzaThyswInZ2wil7-7Vh1hDcu5AOA@z>

On Mon, 7 May 2018, Luis R. Rodriguez wrote:

> __read_mostly can easily be misused by folks, its not meant for
> just read-only data. There are performance reasons for using it, but
> we also don't provide any guidance about its use. Provide a bit more
> guidance over it use.

Acked-by: Christoph Lameter <cl@linux.com>
