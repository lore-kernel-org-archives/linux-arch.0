Return-Path: <SRS0=//km=6U=kvack.org=owner-linux-mm@kernel.org>
Date: Wed, 6 May 2020 16:44:14 -0700
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm: expland documentation over __read_mostly
Message-ID: <20200506234414.GN16070@bombadil.infradead.org>
References: <20200506231353.32451-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506231353.32451-1-mcgrof@kernel.org>
Sender: owner-linux-mm@kvack.org
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: cl@linux.com, akpm@linux-foundation.org, arnd@arndb.de, aquini@redhat.com, keescook@chromium.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200506234414.6dpf3HXWTnKtXXoHH2R_W7thQfqme3uwtUQXwxpecS4@z>

On Wed, May 06, 2020 at 11:13:53PM +0000, Luis Chamberlain wrote:
> + * execute a critial path. We should be mindful and selective of its use.

"critical"
