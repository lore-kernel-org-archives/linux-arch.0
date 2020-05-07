From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] mm: expand documentation over __read_mostly
Date: Thu, 7 May 2020 10:52:22 -0700
Message-ID: <202005071052.1522C624@keescook>
References: <20200507161424.2584-1-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200507161424.2584-1-mcgrof@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: cl@linux.com, akpm@linux-foundation.org, arnd@arndb.de, willy@infradead.org, aquini@redhat.com, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, May 07, 2020 at 04:14:24PM +0000, Luis Chamberlain wrote:
> __read_mostly can easily be misused by folks, its not meant for
> just read-only data. There are performance reasons for using it, but
> we also don't provide any guidance about its use. Provide a bit more
> guidance over its use.
> 
> Acked-by: Christoph Lameter <cl@linux.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
