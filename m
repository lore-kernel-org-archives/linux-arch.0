From: Christopher Lameter <cl@linux.com>
Subject: Re: [PATCH] mm: expland documentation over __read_mostly
Date: Tue, 8 May 2018 07:54:15 -0500 (CDT)
Message-ID: <alpine.DEB.2.21.1805080753590.1849@nuc-kabylake>
References: <20180507231506.4891-1-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180507231506.4891-1-mcgrof@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: tglx@linutronix.de, arnd@arndb.de, keescook@chromium.org, luto@amacapital.net, longman@redhat.com, viro@zeniv.linux.org.uk, willy@infradead.org, ebiederm@xmission.com, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, 7 May 2018, Luis R. Rodriguez wrote:

> __read_mostly can easily be misused by folks, its not meant for
> just read-only data. There are performance reasons for using it, but
> we also don't provide any guidance about its use. Provide a bit more
> guidance over it use.

Acked-by: Christoph Lameter <cl@linux.com>
