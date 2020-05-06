From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm: expland documentation over __read_mostly
Date: Wed, 6 May 2020 16:44:14 -0700
Message-ID: <20200506234414.GN16070@bombadil.infradead.org>
References: <20200506231353.32451-1-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgEFXoX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 May 2020 19:44:23 -0400
Content-Disposition: inline
In-Reply-To: <20200506231353.32451-1-mcgrof@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: cl@linux.com, akpm@linux-foundation.org, arnd@arndb.de, aquini@redhat.com, keescook@chromium.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 11:13:53PM +0000, Luis Chamberlain wrote:
> + * execute a critial path. We should be mindful and selective of its use.

"critical"
